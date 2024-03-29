#!/bin/bash
# https://learn.microsoft.com/en-us/azure/azure-government/documentation-government-get-started-connect-with-cli

az cloud set --name AzureUSGovernment
az login

# confirm cloud has been correclty set
az cloud list --output table
# list US government regions
az account list-locations
