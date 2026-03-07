# Infrastructure Terraform - gamecard-layout

Déploiement du site statique sur AWS S3.

## Prérequis

- [Terraform](https://www.terraform.io/downloads) >= 1.0
- [AWS CLI](https://aws.amazon.com/cli/) configuré
- Credentials AWS (variables d'environnement ou `~/.aws/credentials`)

## Déploiement

### 1. Créer l'infrastructure

```bash
cd infra

# Copier et éditer les variables
cp terraform.tfvars.example terraform.tfvars
# Modifier bucket_name (doit être unique globalement, ex: gamecard-layout-votre-nom)

terraform init
terraform plan
terraform apply
```

### 2. Uploader le code

```bash
./deploy.sh
```

Ou manuellement :

```bash
aws s3 sync .. s3://$(terraform output -raw bucket_name) \
  --exclude ".git/*" --exclude "infra/*" --exclude "*.zip"
```

### 3. URL du site

```bash
terraform output website_url
```

Format : `http://<bucket>.s3-website-<region>.amazonaws.com`

## Variables

| Variable     | Description                    | Défaut    |
|-------------|--------------------------------|-----------|
| bucket_name | Nom du bucket S3 (unique)      | requis    |
| aws_region  | Région AWS                     | eu-west-1 |
| tags        | Tags des ressources            | {}        |
