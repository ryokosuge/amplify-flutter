# amplify_flutter_example

A new Flutter project.

## Setup Amplfy

```
$ npm i -g @aws-amplify/cli
```

```
$ amplify configure
```

## Getting Started

```
$ amplify init
```

```
Note: It is recommended to run this command from the root of your app directory
? Enter a name for the project amplifyflutter
The following configuration will be applied:

Project information
| Name: amplifyflutter
| Environment: dev
| Default editor: Visual Studio Code
| App type: flutter
| Configuration file location: ./lib/

? Initialize the project with the above configuration? Yes
Using default provider  awscloudformation
? Select the authentication method you want to use: AWS profile

For more information on AWS Profiles, see:
https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html

? Please choose the profile you want to use ${PROFILE_NAME}
... log ...
✔ Successfully created initial AWS cloud resources for deployments.
✔ Initialized provider successfully.

Initialized your environment successfully.

Your project has been successfully initialized and connected to the cloud!

Some next steps:
"amplify status" will show you what you've added already and if it's locally configured or deployed
"amplify add <category>" will allow you to add features like user login or a backend API
"amplify push" will build all your local backend resources and provision it in the cloud
"amplify console" to open the Amplify Console and view your project status
"amplify publish" will build all your local backend and frontend resources (if you have hosting category added) and provision it in the cloud

Pro tip:
Try "amplify add api" to create a backend API and then "amplify publish" to deploy everything
```

```
$ amplify add auth
```

```
Using service: Cognito, provided by: awscloudformation

 The current configured provider is Amazon Cognito.

 Do you want to use the default authentication and security configuration? Default configuration
 Warning: you will not be able to edit these selections.
 How do you want users to be able to sign in? Username
 Do you want to configure advanced settings? No, I am done.
Successfully added auth resource amplifyflutterfd665756 locally

Some next steps:
"amplify push" will build all your local backend resources and provision it in the cloud
"amplify publish" will build all your local backend and frontend resources (if you have hosting category added) and provision it in the cloud
```

```
$ amplify add auth storage
```

```
Using service: Cognito, provided by: awscloudformation

 The current configured provider is Amazon Cognito.

 Do you want to use the default authentication and security configuration? Default configuration
 Warning: you will not be able to edit these selections.
 How do you want users to be able to sign in? Username
 Do you want to configure advanced settings? No, I am done.
Successfully added auth resource amplifyflutterfd665756 locally

Some next steps:
"amplify push" will build all your local backend resources and provision it in the cloud
"amplify publish" will build all your local backend and frontend resources (if you have hosting category added) and provision it in the cloud

~/W/g/r/amplify-flutter (main↑3|✚9…) $ amplify add storage
? Please select from one of the below mentioned services: Content (Images, audio, video, etc.)
? Please provide a friendly name for your resource that will be used to label this category in the project: s360ae4bc0
? Please provide bucket name: amplifyflutter98434f6d348f4ce0aa9733b050b1fe58
? Who should have access: Auth users only
? What kind of access do you want for Authenticated users? create/update, read, delete
? Do you want to add a Lambda Trigger for your S3 Bucket? No
Successfully added resource s360ae4bc0 locally

If a user is part of a user pool group, run "amplify update storage" to enable IAM group policies for CRUD operations
Some next steps:
"amplify push" builds all of your local backend resources and provisions them in the cloud
"amplify publish" builds all of your local backend and front-end resources (if you added hosting category) and provisions them in the cloud
```

```
$ amplify push
```

```
✔ Successfully pulled backend environment dev from the cloud.

Current Environment: dev

| Category | Resource name          | Operation | Provider plugin   |
| -------- | ---------------------- | --------- | ----------------- |
| Auth     | amplifyflutterfd665756 | Create    | awscloudformation |
| Storage  | s360ae4bc0             | Create    | awscloudformation |
? Are you sure you want to continue? Yes
⠸ Updating resources in the cloud. This may take a few minutes...

... log ...

✔ All resources are updated in the cloud
```

```
$ flutter run
```

## Delete Project

```
$ amplify delete
? Are you sure you want to continue? This CANNOT be undone. (This will delete all the environments of the project from the cloud and wipe out all the local files created by Amplify CLI) Yes
⠋ Deleting resources from the cloud. This may take a few minutes...
Deleting env: dev.
✔ Project deleted in the cloud.
Project deleted locally.
```