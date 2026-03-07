#!/usr/bin/env bash
# Deploy static files to S3 bucket (run after terraform apply)
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
BUCKET_NAME="${1:-$(terraform -chdir="$SCRIPT_DIR" output -raw bucket_name 2>/dev/null)}"

if [ -z "$BUCKET_NAME" ]; then
  echo "Usage: $0 [bucket_name]"
  echo "  Or run 'terraform apply' first and ensure bucket_name output exists"
  exit 1
fi

echo "Deploying to s3://$BUCKET_NAME"
aws s3 sync "$PROJECT_ROOT" "s3://$BUCKET_NAME" \
  --exclude ".git/*" \
  --exclude "infra/*" \
  --exclude "*.zip" \
  --exclude ".DS_Store" \
  --exclude "*.tfstate*" \
  --exclude ".terraform/*" \
  --cache-control "max-age=3600" \
  --delete

echo "Done. Run 'terraform -chdir=infra output website_url' for the website URL"
