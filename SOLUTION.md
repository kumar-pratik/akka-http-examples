# Complete Pipeline Structure
List of all the branches
  - Master (or Production)
  - Development
  - Testing
## Strategy
- Generate Docker image and push to docker hub with current BUILD_NUMBER as image tag.
- Use Kubernetes Deployment and service for deployment.
- Ask for manual varifiaction before updating the deployment with current image. 
- *site.yml* is a ansible playbook for creating deployment and service.
## Pipeline Workflow
  1. Code compile (For all three branch)
  2. Testing for all three branch.
  3. Generating and archiving fat jar for master and development branch only.
  4. Image build with Dockerfile using the latest artifact (Master branch).
  5. Image push to registry (Master Branch).
  6. Removing local image
  7. Final deployment using ansible and kubernetes with added step of users permission.
  8. Status mail to developer with complete log attached for reference.


