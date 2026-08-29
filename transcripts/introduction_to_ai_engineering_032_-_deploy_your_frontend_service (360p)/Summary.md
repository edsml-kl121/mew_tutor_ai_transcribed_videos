# Introduction to AI Engineering - Deploying a Frontend Service

**Format:** Thai-language lecture with English technical terminology  
**Source:** `introduction_to_ai_engineering_032_-_deploy_your_frontend_service (360p).mp4`

## Overview

This session demonstrates how to package a Streamlit frontend as a Docker image, test it locally, publish it to Docker Hub, and deploy it as a public web service on Render.com. It builds on earlier work covering frontend and backend applications, POST APIs, connecting frontend to backend, and Docker fundamentals.

The instructor uses Podman during the demonstration, but notes that the commands are equivalent to Docker commands if `podman` is replaced with `docker`.

## 1. Deployment Architecture

The application folder contains the main pieces needed to create a container:

- `app.py` for the Streamlit frontend
- `requirements.txt` for Python dependencies
- `Dockerfile` with image build and startup instructions

The deployment flow is:

1. Build a Docker image from the application files.
2. Run the image locally as a container and verify the web application.
3. Tag the image using the Docker Hub username and repository name.
4. Push the tagged image to Docker Hub.
5. Configure Render to pull and run the existing public image.
6. Open the generated public URL and verify the deployed frontend.

This managed-container approach is compared with services such as Google Cloud Run and IBM Cloud Code Engine. It avoids manually provisioning and operating a virtual machine such as EC2 for a simple web service.

## 2. Dockerfile and Application Setup

The demonstrated Dockerfile:

- Starts from a Python 3.11 image
- Creates an application working directory
- Copies `requirements.txt`
- Installs the required dependencies
- Copies `app.py`
- Starts the application with Streamlit

The Streamlit service listens on port `8501`, so the same port must be exposed or mapped when testing the container and configured correctly in the hosting platform.

## 3. Build and Test the Image Locally

Before building, users who have not authenticated with Docker Hub should log in.

The image is built for the AMD64 platform because that is the architecture expected by the Render deployment:

```bash
podman buildx build --platform linux/amd64 -t frontend2 .
```

The instructor then checks that the image exists:

```bash
podman images
```

Run the image locally and map Streamlit's port:

```bash
podman run -p 8501:8501 frontend2
```

Open the local application on port `8501`. This local test confirms that the image and its startup command work before publishing it.

For Docker users, use the same commands with `docker` in place of `podman`.

## 4. Tag and Push to Docker Hub

Docker Hub expects the image name to include the account username. The local image is therefore tagged with a second name:

```bash
podman tag frontend2 <dockerhub-username>/frontend2:latest
```

Tagging does not rebuild or duplicate the application. It associates another name and tag with the same image so it can be pushed to the correct Docker Hub repository.

Push the image:

```bash
podman push <dockerhub-username>/frontend2:latest
```

After the upload completes, verify on Docker Hub that the image and `latest` tag are available. The demonstrated repository is public, so Render does not require registry credentials to pull it.

## 5. Deploy the Existing Image on Render

The Render workflow shown is:

1. Create or open a project on Render.com.
2. Select **Add New** and then **Web Service**.
3. Choose **Existing Image** rather than a Git provider or public Git repository.
4. Paste the Docker Hub image location.
5. Connect the image.
6. Select the free plan for the exercise.
7. Configure environment variables if the application requires them.
8. Deploy the web service.
9. Monitor the deployment logs while Render provisions and starts the container.
10. Open the generated URL and verify that the Streamlit frontend loads.

This frontend does not require environment variables. The instructor notes that a future backend deployment might require values such as API keys or other runtime configuration, which can be entered in Render's environment settings.

## 6. Managed Scaling and Resource Controls

Render can manage infrastructure settings such as:

- CPU and memory allocation
- Number of running instances
- Service scaling
- Container startup and deployment

Some options require a paid tier. The main benefit is that users can adjust resources and replicas without immediately introducing a more complex orchestration platform such as Kubernetes.

## 7. Cost and Cleanup

Even when using a free plan, the instructor recommends stopping resources when they are no longer needed. In Render, go to the service settings and use **Suspend Web Service** to prevent the application from continuing to run or unexpectedly generating charges.

## Takeaways / Action Items

- Package the Streamlit application with `app.py`, `requirements.txt`, and a `Dockerfile`.
- Build for `linux/amd64` when required by the target hosting service.
- Always test the container locally on port `8501` before publishing it.
- Tag the image as `<dockerhub-username>/<image-name>:latest` and push it to Docker Hub.
- Deploy the public image through Render's **Existing Image** web-service option.
- Use environment variables for backend secrets and runtime configuration when needed.
- Review logs to diagnose provisioning or startup problems.
- Suspend the Render service after the exercise if it is no longer needed.
