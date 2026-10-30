#!/bin/bash
# Generate comprehensive PR report with security and cost analysis
# Usage: generate-pr-report.sh <terraform_dir> <environment> <pr_number> <pr_author>

set -euo pipefail

TERRAFORM_DIR="$1"
ENVIRONMENT="$2" 
PR_NUMBER="$3"
PR_AUTHOR="$4"

REPORT_FILE="${TERRAFORM_DIR}/pr-report.md"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S UTC')

echo "📊 Generating comprehensive PR report for ${ENVIRONMENT}..."

# Initialize report
cat > "${REPORT_FILE}" << EOF
# 🚀 GamePlatform Infrastructure Report - PR #${PR_NUMBER}

**Environment**: \`${ENVIRONMENT}\`  
**Author**: @${PR_AUTHOR}  
**Generated**: ${TIMESTAMP}  
**Status**: Planning Phase

---

## 📋 Executive Summary

EOF

# Add Terraform Plan Summary
if [[ -f "${TERRAFORM_DIR}/tfplan" ]]; then
    echo "## 🏗️ Terraform Plan Summary" >> "${REPORT_FILE}"
    echo "" >> "${REPORT_FILE}"
    echo "\`\`\`" >> "${REPORT_FILE}"
    terraform -chdir="${TERRAFORM_DIR}" show -no-color tfplan | head -50 >> "${REPORT_FILE}" 2>/dev/null || echo "Plan summary not available" >> "${REPORT_FILE}"
    echo "\`\`\`" >> "${REPORT_FILE}"
    echo "" >> "${REPORT_FILE}"
fi

# Add Security Analysis
if [[ -f "${TERRAFORM_DIR}/tfsec-results.json" ]]; then
    echo "## 🛡️ Security Analysis (tfsec)" >> "${REPORT_FILE}"
    echo "" >> "${REPORT_FILE}"
    
    # Parse tfsec results
    CRITICAL_ISSUES=$(jq '.results[] | select(.severity == "CRITICAL") | length' "${TERRAFORM_DIR}/tfsec-results.json" 2>/dev/null || echo "0")
    HIGH_ISSUES=$(jq '.results[] | select(.severity == "HIGH") | length' "${TERRAFORM_DIR}/tfsec-results.json" 2>/dev/null || echo "0")
    MEDIUM_ISSUES=$(jq '.results[] | select(.severity == "MEDIUM") | length' "${TERRAFORM_DIR}/tfsec-results.json" 2>/dev/null || echo "0")
    LOW_ISSUES=$(jq '.results[] | select(.severity == "LOW") | length' "${TERRAFORM_DIR}/tfsec-results.json" 2>/dev/null || echo "0")
    
    # Security status badge
    if [[ ${CRITICAL_ISSUES} -gt 0 ]]; then
        echo "🔴 **CRITICAL SECURITY ISSUES FOUND** - Requires immediate attention" >> "${REPORT_FILE}"
    elif [[ ${HIGH_ISSUES} -gt 0 ]]; then
        echo "🟡 **HIGH SECURITY ISSUES FOUND** - Should be addressed before apply" >> "${REPORT_FILE}"
    else
        echo "✅ **NO CRITICAL/HIGH SECURITY ISSUES** - Security scan passed" >> "${REPORT_FILE}"
    fi
    
    echo "" >> "${REPORT_FILE}"
    echo "| Severity | Count |" >> "${REPORT_FILE}"
    echo "|----------|-------|" >> "${REPORT_FILE}"
    echo "| 🔴 Critical | ${CRITICAL_ISSUES} |" >> "${REPORT_FILE}"
    echo "| 🟠 High | ${HIGH_ISSUES} |" >> "${REPORT_FILE}"
    echo "| 🟡 Medium | ${MEDIUM_ISSUES} |" >> "${REPORT_FILE}"
    echo "| 🔵 Low | ${LOW_ISSUES} |" >> "${REPORT_FILE}"
    echo "" >> "${REPORT_FILE}"
    
    # Include markdown results if available
    if [[ -f "${TERRAFORM_DIR}/tfsec-results.md" ]]; then
        echo "<details>" >> "${REPORT_FILE}"
        echo "<summary>🔍 Detailed Security Findings</summary>" >> "${REPORT_FILE}"
        echo "" >> "${REPORT_FILE}"
        cat "${TERRAFORM_DIR}/tfsec-results.md" >> "${REPORT_FILE}"
        echo "</details>" >> "${REPORT_FILE}"
        echo "" >> "${REPORT_FILE}"
    fi
fi

# Add Cost Analysis
if [[ -f "${TERRAFORM_DIR}/infracost-results.json" ]]; then
    echo "## 💰 Cost Analysis (infracost)" >> "${REPORT_FILE}"
    echo "" >> "${REPORT_FILE}"
    
    # Extract cost information
    MONTHLY_COST=$(jq -r '.totalMonthlyCost // "0"' "${TERRAFORM_DIR}/infracost-results.json" 2>/dev/null || echo "0")
    HOURLY_COST=$(jq -r '.totalHourlyCost // "0"' "${TERRAFORM_DIR}/infracost-results.json" 2>/dev/null || echo "0")
    
    echo "💵 **Estimated Monthly Cost**: \$${MONTHLY_COST}" >> "${REPORT_FILE}"
    echo "💵 **Estimated Hourly Cost**: \$${HOURLY_COST}" >> "${REPORT_FILE}"
    echo "" >> "${REPORT_FILE}"
    
    # Cost breakdown table
    if [[ -f "${TERRAFORM_DIR}/infracost-results.txt" ]]; then
        echo "<details>" >> "${REPORT_FILE}"
        echo "<summary>📊 Detailed Cost Breakdown</summary>" >> "${REPORT_FILE}"
        echo "" >> "${REPORT_FILE}"
        echo "\`\`\`" >> "${REPORT_FILE}"
        cat "${TERRAFORM_DIR}/infracost-results.txt" >> "${REPORT_FILE}"
        echo "\`\`\`" >> "${REPORT_FILE}"
        echo "</details>" >> "${REPORT_FILE}"
        echo "" >> "${REPORT_FILE}"
    fi
    
    # Cost recommendations for PR environments
    if [[ "${ENVIRONMENT}" == pr-* ]]; then
        echo "### 💡 Cost Optimization Recommendations for PR Environment" >> "${REPORT_FILE}"
        echo "" >> "${REPORT_FILE}"
        echo "- ⏰ **Temporary Environment**: This PR environment will be automatically destroyed when PR is closed" >> "${REPORT_FILE}"
        echo "- 🔧 **Resource Configuration**: Using cost-optimized settings (512 CPU, 1024 MB memory)" >> "${REPORT_FILE}"
        echo "- 📊 **Expected Runtime**: Estimated 2-5 days average per PR environment" >> "${REPORT_FILE}"
        echo "- 💵 **Total PR Cost**: ~\$$(echo "${MONTHLY_COST} * 0.1666" | bc -l 2>/dev/null || echo "N/A") (assuming 5 days)" >> "${REPORT_FILE}"
        echo "" >> "${REPORT_FILE}"
    fi
fi

# Add Resource Summary
echo "## 📦 Resource Summary" >> "${REPORT_FILE}"
echo "" >> "${REPORT_FILE}"

if [[ -f "${TERRAFORM_DIR}/tfplan" ]]; then
    # Count resources from plan
    RESOURCES_TO_ADD=$(terraform -chdir="${TERRAFORM_DIR}" show -json tfplan 2>/dev/null | jq '[.resource_changes[] | select(.change.actions[] == "create")] | length' 2>/dev/null || echo "0")
    RESOURCES_TO_CHANGE=$(terraform -chdir="${TERRAFORM_DIR}" show -json tfplan 2>/dev/null | jq '[.resource_changes[] | select(.change.actions[] == "update")] | length' 2>/dev/null || echo "0")
    RESOURCES_TO_DESTROY=$(terraform -chdir="${TERRAFORM_DIR}" show -json tfplan 2>/dev/null | jq '[.resource_changes[] | select(.change.actions[] == "delete")] | length' 2>/dev/null || echo "0")
    
    echo "| Action | Count |" >> "${REPORT_FILE}"
    echo "|--------|-------|" >> "${REPORT_FILE}"
    echo "| ➕ Create | ${RESOURCES_TO_ADD} |" >> "${REPORT_FILE}"
    echo "| 🔄 Change | ${RESOURCES_TO_CHANGE} |" >> "${REPORT_FILE}"
    echo "| ❌ Destroy | ${RESOURCES_TO_DESTROY} |" >> "${REPORT_FILE}"
    echo "" >> "${REPORT_FILE}"
fi

# Add Environment-specific Information
if [[ "${ENVIRONMENT}" == pr-* ]]; then
    PR_ID=$(echo "${ENVIRONMENT}" | sed 's/pr-//')
    echo "## 🔗 Environment URLs (Available after apply)" >> "${REPORT_FILE}"
    echo "" >> "${REPORT_FILE}"
    echo "- 🖥️ **Server**: \`https://pr-${PR_ID}.dev.gameplatform.click\`" >> "${REPORT_FILE}"
    echo "- 🌐 **Lobby**: \`https://lobby-pr-${PR_ID}.dev.gameplatform.click\`" >> "${REPORT_FILE}"
    echo "- 📊 **CloudWatch Logs**: \`/ecs/pr-${PR_ID}/server\` and \`/ecs/pr-${PR_ID}/lobby\`" >> "${REPORT_FILE}"
    echo "" >> "${REPORT_FILE}"
    
    echo "## ⚡ Quick Actions" >> "${REPORT_FILE}"
    echo "" >> "${REPORT_FILE}"
    echo "- 🚀 **Apply Changes**: Comment \`atlantis apply\` to deploy this environment" >> "${REPORT_FILE}"
    echo "- 🔄 **Re-plan**: Comment \`atlantis plan\` to regenerate this report" >> "${REPORT_FILE}"
    echo "- 🗑️ **Destroy**: Environment will be automatically destroyed when PR is closed/merged" >> "${REPORT_FILE}"
fi

# Add Footer
echo "" >> "${REPORT_FILE}"
echo "---" >> "${REPORT_FILE}"
echo "" >> "${REPORT_FILE}"
echo "📋 **Report Generated by**: GamePlatform DevOps Pipeline  " >> "${REPORT_FILE}"
echo "🔧 **Tools Used**: Terraform, tfsec, infracost, Atlantis  " >> "${REPORT_FILE}"
echo "⏰ **Next Update**: Report will update automatically on new commits  " >> "${REPORT_FILE}"

echo "✅ Report generated successfully: ${REPORT_FILE}"

# Output report to Atlantis (this will appear in the PR comment)
cat "${REPORT_FILE}"