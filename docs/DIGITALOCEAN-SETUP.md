# Clawitzer on DigitalOcean – Step by step

Use a DigitalOcean Droplet to test the Clawitzer Agent (or later to build the ISO). Two ways: **manual** (website) or **Terraform** (one command).

---

## What you need

- A [DigitalOcean](https://www.digitalocean.com/) account (free trial works).
- A **Personal Access Token**: DigitalOcean → **API** → **Tokens** → **Generate New Token** (read + write). Copy it; you’ll use it as `DO_TOKEN` below.

---

## Option 1: Create the Droplet in the website (easiest)

1. Log in at [cloud.digitalocean.com](https://cloud.digitalocean.com/).
2. Click **Create** → **Droplets**.
3. Choose:
   - **Image**: Ubuntu 24.04 (LTS).
   - **Plan**: Basic, **$6/mo** (1 GB RAM / 1 CPU) is enough.
   - **Region**: pick one close to you (e.g. New York, San Francisco).
   - **Authentication**: either **SSH key** (if you have one) or **Password** (DigitalOcean will email the root password).
4. Click **Create Droplet**. Wait ~1 minute.
5. Copy the **IP address** (e.g. `164.92.xxx.xxx`).
6. Open a terminal and connect:
   - **If you used password**:  
     `ssh root@YOUR_IP`  
     (use the password from the email.)
   - **If you used SSH key**:  
     `ssh root@YOUR_IP`
7. When you see `root@ubuntu-...:~#`, you’re in. Continue with **“Commands to run on the Droplet”** below.

---

## Option 2: Create the Droplet with Terraform

If you have [Terraform](https://developer.hashicorp.com/terraform/install) installed:

```bash
cd cloud/terraform/digitalocean
export TF_VAR_do_token="YOUR_DIGITALOCEAN_TOKEN"
terraform init
terraform apply -auto-approve
```

Terraform will print the droplet **IP** and the **ssh** command. Run that to connect, then use **“Commands to run on the Droplet”** below.

---

## Commands to run on the Droplet (after you’re SSH’d in)

Run these **on the Droplet** (as `root`):

```bash
# 1. Install Node.js 22
curl -fsSL https://deb.nodesource.com/setup_22.x | bash -
apt-get install -y nodejs

# 2. Clone the Clawitzer repo
git clone https://github.com/MRdulaenterprise/Clawizter.git /opt/clawitzer
cd /opt/clawitzer

# 3. Install the agent and copy overlay (like the ISO would)
cp -a /opt/clawitzer/distro/overlay/etc/* /
cp -a /opt/clawitzer/distro/overlay/usr/* /usr/
mkdir -p /usr/lib/clawitzer
cp -a /opt/clawitzer/agent/* /usr/lib/clawitzer/
cd /usr/lib/clawitzer && npm install --omit=dev

# 4. Start the Clawitzer Agent (for testing; not systemd yet)
node /usr/lib/clawitzer/lib/daemon.js &
sleep 2

# 5. Check it’s running
curl -s http://127.0.0.1:19898/ | head -5
```

If you see JSON with `"name":"Clawitzer Agent"`, it’s working.

**To reach it from your browser (optional):**  
On your Mac, run in a **new terminal** (not on the Droplet):

```bash
ssh -L 19898:127.0.0.1:19898 root@YOUR_DROPLET_IP
```

Leave that SSH session open. Then open **http://127.0.0.1:19898** in your browser; you’ll see the agent (or the placeholder message).

---

## When you’re done

- In the DO dashboard: **Droplets** → select your droplet → **Destroy** (so you’re not charged).
- Or with Terraform: `cd cloud/terraform/digitalocean && terraform destroy -auto-approve`.
