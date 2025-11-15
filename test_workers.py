import time
import socket
import ray

# Connect to existing cluster
ray.init(address="auto")

# Remote function using 1 GPU so autoscaler must launch many workers
@ray.remote(num_gpus=1)
def whoami(i):
    # Return hostname + index
    return i, socket.gethostname()

def main():
    print("Submitting test tasks...")

    tasks = [whoami.remote(i) for i in range(16)]  # 16 tasks → 2 A3 workers needed
    print("Waiting for results...")

    results = ray.get(tasks)

    print("\n=== RESULTS ===")
    for idx, host in results:
        print(f"Task {idx:02d} ran on {host}")

    print("\nCluster resources now:")
    print(ray.cluster_resources())

    print("\nAutoscaling test complete.")

if __name__ == "__main__":
    main()
