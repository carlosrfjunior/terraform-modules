<p align="center">
<a href="https://github.com/carlosrfjunior/helm-charts">
<image src="../assets/hotmart-logo.png" style="width: 300px;">
</a>
</p>

# Custom Networking

- Enable or disable custom networking

```hcl
vpc_cni = {
        custom_networking = true
}

managed_node_groups = {

    # Naming convention exemplified above
    owner-env-suffix-resource-main = {
      ami_type = "AL2023_x86_64_STANDARD"

      ## Before enabling this feature, check if the instance class supports trunking.
      instance_types = [
        "m6i.large",
        "m7i.large"
      ]

    }

  }

```
## Recommendation
> _Trunking is a networking feature in Amazon Elastic Container Service (ECS) that increases the number of tasks that can be placed on an Amazon EC2 Linux instance. Trunking works by multiplexing data over a shared communication link, which can increase capacity by 5 to 17 times._
>
> **To use trunking, an EC2 instance must have the following:**
>
> Use version **1.28.1** or later of the container agent
> If using an Amazon ECS-optimized AMI, use at least version **1.28.1-2** of the ecs-init package
>
> Here are some examples of how trunking can increase task limits for different instance types:
>
> - **a1.2xlarge:** Task limit increases from 3 to 40
> - **a1.4xlarge:** Task limit increases from 7 to 60
> - **m5.large:** Task limit increases from 2 to 10
> - **m5.xlarge:** Task limit increases from 3 to 20

**References:**

- [Amazon ECS Container Instance ENI](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/container-instance-eni.html)
- [ENI Trunking Supported Instance Types](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/eni-trunking-supported-instance-types.html)

<figure>
<img src="../assets/custom-netoworking.png" style="width:600px;"
        alt="Custom Networking Architecture">
</figure>

- **Referencies:**
  - <https://docs.aws.amazon.com/eks/latest/userguide/cni-custom-network.html>
  - <https://aws.github.io/aws-eks-best-practices/networking/custom-networking/>
  - <https://docs.aws.amazon.com/eks/latest/userguide/cni-increase-ip-addresses.html>
  - <https://github.com/aws/amazon-vpc-cni-k8s?tab=readme-ov-file>
  - <https://github.com/aws-samples/terraform-cni-custom-network-sample>
