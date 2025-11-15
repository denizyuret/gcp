# Once machine is launched login with:
# gcloud compute ssh l4-pp-4g --zone=us-west1-a

PROJECT=project-for-deniz
NAME=l4-pp-4g
DISK_GB=200

for ZONE in us-west1-a us-west1-b us-west1-c us-west4-a us-west4-c us-central1-a us-central1-b us-central1-c; do
gcloud compute instances create $NAME \
  --project=$PROJECT \
  --zone=$ZONE \
  --machine-type=g2-standard-48 \
  --accelerator=type=nvidia-l4,count=4 \
  --maintenance-policy=TERMINATE \
  --provisioning-model=STANDARD \
  --boot-disk-size=${DISK_GB}GB \
  --image-family=pytorch-2-7-cu128-ubuntu-2204-nvidia-570 \
  --image-project=deeplearning-platform-release \
  --scopes=https://www.googleapis.com/auth/cloud-platform && break || echo "no capacity on $ZONE"
done

