import boto3
import csv

# Initialize a boto3 client
config_service = boto3.client('config')

def fetch_all_config_rules():
    """Fetches all AWS Config rules."""
    config_rules = []
    paginator = config_service.get_paginator('describe_config_rules')
    for page in paginator.paginate():
        for rule in page['ConfigRules']:
            config_rules.append(rule['ConfigRuleName'])
    return config_rules

def fetch_non_compliant_resources_by_rule(rule_name):
    """Fetches non-compliant resources for a given Config rule."""
    non_compliant_resources = []
    paginator = config_service.get_paginator('get_compliance_details_by_config_rule')
    for page in paginator.paginate(ConfigRuleName=rule_name, ComplianceTypes=['NON_COMPLIANT']):
        for result in page['EvaluationResults']:
            eval_qualifier = result['EvaluationResultIdentifier']['EvaluationResultQualifier']
            resource_name = eval_qualifier.get('ResourceName', 'N/A')  # Use 'N/A' if ResourceName is not available
            resource_type = eval_qualifier.get('ResourceType', 'Unknown')  # Retrieve ResourceType, fallback to 'Unknown'
            compliance_type = result['ComplianceType']

            # If ResourceName is not available, you might want to use a combination of ResourceType and ResourceId
            if resource_name == 'N/A':
                resource_id = eval_qualifier.get('ResourceId', 'Unknown')
                resource_name = f"{resource_type}/{resource_id}"

            non_compliant_resources.append([resource_name, rule_name, compliance_type])
    return non_compliant_resources


def write_to_csv(non_compliant_resources):
    """Writes non-compliant resource details to a CSV file."""
    with open('non_compliant_resources.csv', 'w', newline='') as file:
        writer = csv.writer(file)
        writer.writerow(['Resource Name', 'Rule Evaluated', 'Compliance Status'])
        writer.writerows(non_compliant_resources)

def main():
    all_config_rules = fetch_all_config_rules()
    all_non_compliant_resources = []
    for rule_name in all_config_rules:
        non_compliant_resources = fetch_non_compliant_resources_by_rule(rule_name)
        all_non_compliant_resources.extend(non_compliant_resources)
    
    write_to_csv(all_non_compliant_resources)
    print("CSV file 'non_compliant_resources.csv' has been created.")

if __name__ == "__main__":
    main()
