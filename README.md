# networking-lab
This repository is designed as a sandbox to test various Azure networking concepts.

# Setting up

1. Configure an app registration and federated workload identity in Azure - https://docs.microsoft.com/en-us/azure/active-directory/develop/workload-identity-federation
2. Grant the identity "Contributor" access on the target subscription.
3. Set up an ssh key on the device you're using.
4. Create the following variables in GitHub:
    ARM_CLIENT_ID - The app ID of the app registration for GitHub Actions
    ARM_TENANT_ID - The target Entra Tenant's ID
    ARM_SUBSCRIPTION_ID - The target subscription ID
    TF_STATE_STORAGE_ACCOUNT_NAME - The name of the storage account to hold TF state
    TF_STATE_STORAGE_ACCOUNT_CONTAINER_NAME - The name of the storage container to hold the TF state
    TF_VAR_SSH_PUBLIC_KEY - The SSH public key of the lab user, created in step 3.
5. Create a storage account and container to host TF state.
6. Grant the workload identity the 'Storage Blob Data Owner' role on the storage account.
