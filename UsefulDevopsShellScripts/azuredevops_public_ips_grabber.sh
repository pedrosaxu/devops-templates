#!/bin/bash

#   In some setups, you may need to know the range of IP addresses where agents are deployed. 
#   For instance, if you need to grant the hosted agents access through a firewall, you may 
#   wish to restrict that access by IP address. Because Azure DevOps uses the Azure global network, 
#   IP ranges vary over time. We publish a weekly JSON file listing IP ranges for Azure datacenters,
#   broken out by region. This file is updated weekly with new planned IP ranges. The new IP ranges 
#   become effective the following week. We recommend that you check back frequently (at least once every week) 
#   to ensure you keep an up-to-date list. If agent jobs begin to fail, a key first troubleshooting 
#   step is to make sure your configuration matches the latest list of IP addresses. The IP address 
#   ranges for the hosted agents are listed in the weekly file under AzureCloud.<region>, such as 
#   AzureCloud.westus for the West US region.

#   Your hosted agents run in the same Azure geography as your organization. Each geography contains 
#   one or more regions. While your agent may run in the same region as your organization, it is not 
#   guaranteed to do so. To obtain the complete list of possible IP ranges for your agent, you must 
#   use the IP ranges from all of the regions that are contained in your geography. For example, if 
#   your organization is located in the United States geography, you must use the IP ranges for all 
#   of the regions in that geography.

#   To determine your geography, navigate to https://dev.azure.com/<your_organization>/_settings/organizationOverview, 
#   get your region, and find the associated geography from the Azure geography table. Once you have 
#   identified your geography, use the IP ranges from the weekly file for all regions in that geography.

# Cleaning up old files #
rm -rf azuredevops_public_ips
mkdir azuredevops_public_ips
cd azuredevops_public_ips

filename=$(curl -s https://www.microsoft.com/en-us/download/details.aspx?id=56519 | grep -o 'ServiceTags_Public_.*\.json')
wget "https://download.microsoft.com/download/7/1/D/71D86715-5596-4529-9B13-DA13A5DE5B63/$filename"

###### Azure Devops region names ######

# Brazilian region names
cat ServiceTags_Public_*.json | grep "\"name\": \"AzureDevOps.*Brazil*" | cut -d\" -f4 > all_region_names && \

# EUA region names
cat ServiceTags_Public_*.json | grep "\"name\": \"AzureDevOps.*CentralUS*" | cut -d\" -f4 >> all_region_names && \
cat ServiceTags_Public_*.json | grep "\"name\": \"AzureDevOps.*EastUS*" | cut -d\" -f4 >> all_region_names && \
cat ServiceTags_Public_*.json | grep "\"name\": \"AzureDevOps.*NorthCentralUS*" | cut -d\" -f4 >> all_region_names && \
cat ServiceTags_Public_*.json | grep "\"name\": \"AzureDevOps.*SouthCentralUS*" | cut -d\" -f4 >> all_region_names && \
cat ServiceTags_Public_*.json | grep "\"name\": \"AzureDevOps.*WestCentralUS*" | cut -d\" -f4 >> all_region_names && \
cat ServiceTags_Public_*.json | grep "\"name\": \"AzureDevOps.*WestUS*" | cut -d\" -f4 >> all_region_names && \

###### Azure Cloud region names ######

# Brazilian region names
cat ServiceTags_Public_*.json | grep "\"name\": \"AzureCloud.*brazil*" | cut -d\" -f4 >> all_region_names

# EUA region names

cat ServiceTags_Public_*.json | grep "\"name\": \"AzureCloud.*centralus*" | cut -d\" -f4 >> all_region_names
cat ServiceTags_Public_*.json | grep "\"name\": \"AzureCloud.*eastus*" | cut -d\" -f4 >> all_region_names
cat ServiceTags_Public_*.json | grep "\"name\": \"AzureCloud.*usstage*" | cut -d\" -f4 >> all_region_names
cat ServiceTags_Public_*.json | grep "\"name\": \"AzureCloud.*southcentralus*" | cut -d\" -f4 >> all_region_names
cat ServiceTags_Public_*.json | grep "\"name\": \"AzureCloud.*northcentralus*" | cut -d\" -f4 >> all_region_names
cat ServiceTags_Public_*.json | grep "\"name\": \"AzureCloud.*westcentralus*" | cut -d\" -f4 >> all_region_names
cat ServiceTags_Public_*.json | grep "\"name\": \"AzureCloud.*westus*" | cut -d\" -f4 >> all_region_names


# Create a file to save the regions' IP addresses

touch all_addresses
for region in `cat all_region_names`; 
    do
        echo "Region $region added"
        cat ServiceTags_Public_*.json | jq --compact-output --raw-output '.values[] | select( .id == "'$region'" ).properties.addressPrefixes | .[]' >> all_addresses;

done 

# Count current lines
lines_count=$(wc -l all_addresses)
echo "\nTotal IP addresses before removing duplates: $(wc -l < all_addresses)"

# Remove duplicates
cat all_addresses | sort -u > all_addresses.tmp && mv all_addresses.tmp all_addresses

echo "Total IP addresses after removing duplates: $(wc -l < all_addresses)"

# Separate IPV4 and IPV6
cat all_addresses | grep -E "([0-9]{1,3}[\.]){3}[0-9]{1,3}" >> ipv4_addresses
echo "\nIPV4 total count: $(wc -l  < ipv4_addresses)"

cat all_addresses | grep -E "(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))" >> ipv6_addresses
echo "IPV6 total count: $(wc -l < ipv6_addresses)"


# Comma separated, instead of line break separated
tr '\n' ',' < ipv4_addresses > ipv4_addresses.tmp && mv ipv4_addresses.tmp ipv4_addresses
tr '\n' ',' < ipv6_addresses > ipv6_addresses.tmp && mv ipv6_addresses.tmp ipv6_addresses

echo "\nThe output files are saved on $(pwd):"
echo "   - All addresses, line break separated: $(pwd)/all_addresses"
echo "   - IPV4 only, comma separated: $(pwd)/ipv4_addresses"
echo "   - IPV6 only, comma separated: $(pwd)/ipv6_addresses"

cd ..