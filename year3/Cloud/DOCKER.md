Docker automates the deployment of apps in software containers. Allows devs to package an app and its dependencies in a standardised container, making it run consistently across environments.

Containers are like intermodal shipping containers. The encapsulate an app and its dependencies for seamless transport across platforms

Benefits:
- Lightweight: Containers share the OS kernel, making them more efficient than VMs and reducing overhead like memory and storage 
- Portable: Containers can run on local machine, cloud, or production server
- Open Standards
- Efficient: Layered file system means many containers can share common files, reducing disk space usage and speeding up image downloads

Docker container share the host OS kernel and contain only the app and its dependencies. Normal VMs also have all the binaries, libraries, and apps, but this makes Docker more lightweight

Docker Components:
- Engine: Core tat manages containers
- Hub: Public reg for sharing container images
- File: Script defining how to build an image
- Images: Read-only templates defining how to create Docker Templates

Use Cases of Docker:
- Create an environment where devs can easily share
- Replicates production environments for testing and QA 
- Allows for continuous integration ease by allowing for easy package transport