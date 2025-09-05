# Okta - R&T Terraform Package - Custom Admin Roles

This folder contains all the related files required to create custom admin roles in Okta.
The module uses the following terraform resources:

1. [okta_resource_set](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/resource_set)
2. [okta_admin_role_custom](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/admin_role_custom)
3. [okta_admin_role_custom_assignments](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/admin_role_custom_assignments)
4. [okta_user_admin_roles](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/user_admin_roles)

### Description

This module is used to create the custom admin roles required for service accounts like Splunk and Profile Services. The `custom_admin_roles.json` file defines all the resource sets, the roles and the corresponding assignements to an admin role. The module also supports assigning built in admin roles to users. Below is a reference for all the custom admin role permissions and the built in roles supported today:

**Custom Admin role Permissions**

- okta.users.manage
- okta.users.create
- okta.users.read
- okta.users.credentials.manage
- okta.users.credentials.resetFactors
- okta.users.credentials.resetPassword
- okta.users.credentials.expirePassword
- okta.users.userprofile.manage
- okta.users.lifecycle.manage
- okta.users.lifecycle.activate
- okta.users.lifecycle.deactivate
- okta.users.lifecycle.suspend
- okta.users.lifecycle.unsuspend
- okta.users.lifecycle.delete
- okta.users.lifecycle.unlock
- okta.users.lifecycle.clearSessions
- okta.users.groupMembership.manage
- okta.users.appAssignment.manage
- okta.users.apitokens.manage
- okta.users.apitokens.read
- okta.groups.manage
- okta.groups.create
- okta.groups.members.manage
- okta.groups.read
- okta.groups.appAssignment.manage
- okta.apps.read
- okta.apps.manage
- okta.apps.assignment.manage
- okta.profilesources.import.run
- okta.authzServers.read
- okta.users.userprofile.manage
- okta.authzServers.manage
- okta.customizations.read
- okta.customizations.manage
- okta.identityProviders.read
- okta.identityProviders.manage
- okta.workflows.read
- okta.workflows.invoke
- okta.governance.accessCertifications.manage
- okta.governance.accessRequests.manage
- okta.apps.manageFirstPartyApps
- okta.agents.manage
- okta.agents.register
- okta.agents.view
- okta.directories.manage
- okta.directories.read
- okta.devices.manage
- okta.devices.lifecycle.manage
- okta.devices.lifecycle.activate
- okta.devices.lifecycle.deactivate
- okta.devices.lifecycle.suspend
- okta.devices.lifecycle.unsuspend
- okta.devices.lifecycle.delete
- okta.devices.read
- okta.iam.read
- okta.support.cases.manage

**Built-in Admin Roles**

- APP_ADMIN
- ORG_ADMIN
- API_ACCESS_MANAGEMENT_ADMIN
- GROUP_MEMBERSHIP_ADMIN
- HELP_DESK_ADMIN
- REPORT_ADMIN
- READ_ONLY_ADMIN
- SUPER_ADMIN
- USER_ADMIN
