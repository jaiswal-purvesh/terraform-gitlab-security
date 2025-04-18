import json
import os

REPORT_DIR = "security-reports"
HTML_REPORT = os.path.join(REPORT_DIR, "summary-report.html")

sections = []

def load_json(filename):
    path = os.path.join(REPORT_DIR, filename)
    if not os.path.exists(path):
        return []
    with open(path) as f:
        try:
            return json.load(f)
        except json.JSONDecodeError:
            return []

def create_section(title, findings):
    if not findings:
        return f"<h2>{title}</h2><p>No issues found ✅</p>"
    html = f"<h2>{title}</h2><ul>"
    for finding in findings[:50]:
        html += f"<li><pre>{json.dumps(finding, indent=2)}</pre></li>"
    html += "</ul>"
    return html

sections.append(create_section("Checkov", load_json("checkov.json")))
sections.append(create_section("tfsec", load_json("tfsec.json")))
sections.append(create_section("Terrascan", load_json("terrascan.json")))
sections.append(create_section("Trivy", load_json("trivy.json")))
sections.append(create_section("Gitleaks", load_json("gitleaks.json")))

html_content = f"""
<html>
<head>
  <title>Terraform Security Report</title>
  <style>
    body {{ font-family: Arial; background: #f5f5f5; padding: 30px; }}
    h2 {{ background: #333; color: #fff; padding: 10px; }}
    pre {{ background: #eee; padding: 10px; border-radius: 5px; }}
  </style>
</head>
<body>
  <h1>Terraform Security Scan Report</h1>
  {''.join(sections)}
</body>
</html>
"""

with open(HTML_REPORT, "w") as f:
    f.write(html_content)

print(f"✅ Report generated at: {HTML_REPORT}")
