#!/bin/bash
# Check cost thresholds and generate warnings/failures based on environment
# Usage: check-cost-thresholds.sh <infracost_json_file> <environment_type>

set -euo pipefail

INFRACOST_FILE="$1"
ENVIRONMENT_TYPE="$2"

if [[ ! -f "${INFRACOST_FILE}" ]]; then
    echo "❌ Error: Infracost file ${INFRACOST_FILE} not found"
    exit 1
fi

# Extract monthly cost from infracost results
MONTHLY_COST=$(jq -r '.totalMonthlyCost // "0"' "${INFRACOST_FILE}" 2>/dev/null || echo "0")

echo "💰 Checking cost thresholds for ${ENVIRONMENT_TYPE}..."
echo "📊 Estimated monthly cost: \$${MONTHLY_COST}"

# Define thresholds based on environment type
case "${ENVIRONMENT_TYPE}" in
    "pr-"*|"ephemeral")
        MAX_COST="100"
        WARNING_COST="75"
        ENVIRONMENT_NAME="PR/Ephemeral"
        ;;
    "dev"*)
        MAX_COST="500"
        WARNING_COST="400"  
        ENVIRONMENT_NAME="Development"
        ;;
    "stg"*|"staging"*)
        MAX_COST="1000"
        WARNING_COST="800"
        ENVIRONMENT_NAME="Staging"
        ;;
    "prd"*|"prod"*|"production"*)
        MAX_COST="5000"
        WARNING_COST="4000"
        ENVIRONMENT_NAME="Production"
        ;;
    "shared-infrastructure")
        MAX_COST="2000"
        WARNING_COST="1500"
        ENVIRONMENT_NAME="Shared Infrastructure"
        ;;
    *)
        echo "⚠️ Warning: Unknown environment type '${ENVIRONMENT_TYPE}', using default thresholds"
        MAX_COST="1000"
        WARNING_COST="750"
        ENVIRONMENT_NAME="Unknown"
        ;;
esac

echo "🎯 ${ENVIRONMENT_NAME} thresholds: Warning=\$${WARNING_COST}, Max=\$${MAX_COST}"

# Compare costs (using bc for floating point comparison)
COST_EXCEEDED_MAX=$(echo "${MONTHLY_COST} > ${MAX_COST}" | bc -l 2>/dev/null || echo "0")
COST_EXCEEDED_WARNING=$(echo "${MONTHLY_COST} > ${WARNING_COST}" | bc -l 2>/dev/null || echo "0")

# Generate appropriate response
if [[ "${COST_EXCEEDED_MAX}" == "1" ]]; then
    echo "🔴 COST THRESHOLD EXCEEDED!"
    echo "💸 Monthly cost \$${MONTHLY_COST} exceeds maximum threshold \$${MAX_COST} for ${ENVIRONMENT_NAME}"
    echo ""
    echo "🚨 REQUIRED ACTIONS:"
    echo "- Review resource configuration for cost optimization"
    echo "- Consider using smaller instance sizes or fewer resources"
    echo "- For PR environments, verify this is expected for testing"
    echo "- Get approval from team lead before proceeding with apply"
    
    # For automated environments, suggest alternatives
    if [[ "${ENVIRONMENT_TYPE}" == "pr-"* ]]; then
        echo ""
        echo "💡 PR Environment Cost Optimization Suggestions:"
        echo "- Reduce ECS Fargate CPU from 1024 to 512 units"
        echo "- Reduce memory from 2048MB to 1024MB"
        echo "- Consider using burstable performance instances"
    fi
    
    # Don't fail for PR environments, just warn
    if [[ "${ENVIRONMENT_TYPE}" != "pr-"* ]]; then
        echo ""
        echo "❌ Failing deployment due to cost threshold exceeded"
        exit 1
    fi
    
elif [[ "${COST_EXCEEDED_WARNING}" == "1" ]]; then
    echo "🟡 Cost warning threshold exceeded"
    echo "⚠️ Monthly cost \$${MONTHLY_COST} exceeds warning threshold \$${WARNING_COST} for ${ENVIRONMENT_NAME}"
    echo ""
    echo "📋 RECOMMENDED ACTIONS:"
    echo "- Review the cost breakdown below"
    echo "- Verify resource configuration is appropriate"
    echo "- Consider cost optimization opportunities"
    echo "- Monitor costs after deployment"
    
else
    echo "✅ Cost within acceptable thresholds"
    echo "💚 Monthly cost \$${MONTHLY_COST} is below warning threshold \$${WARNING_COST}"
fi

# Generate cost breakdown summary
echo ""
echo "📊 Cost Breakdown Summary:"
if command -v jq >/dev/null 2>&1; then
    jq -r '.projects[]?.breakdown?.resources[]? | select(.monthlyCost != null and .monthlyCost > 0) | "- \(.name): $\(.monthlyCost)"' "${INFRACOST_FILE}" 2>/dev/null | head -10 || echo "Detailed breakdown not available"
else
    echo "jq not available for detailed breakdown"
fi

# Generate cost optimization recommendations
echo ""
echo "💡 General Cost Optimization Tips:"
echo "- Use shared resources (ALB, NAT Gateway) when possible"
echo "- Right-size ECS Fargate resources based on actual usage"
echo "- Enable auto-scaling to optimize for demand"
echo "- Use CloudWatch to monitor actual resource utilization"
echo "- Consider using reserved instances for long-running resources"

# For shared infrastructure, provide additional context
if [[ "${ENVIRONMENT_TYPE}" == "shared-infrastructure" ]]; then
    echo ""
    echo "🏗️ Shared Infrastructure Cost Context:"
    echo "- These costs are amortized across all environments"
    echo "- NAT Gateway and ALB costs are shared by all PR environments"  
    echo "- Consider the total cost savings from resource sharing"
fi

echo ""
echo "✅ Cost threshold check completed"