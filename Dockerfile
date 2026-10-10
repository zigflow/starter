FROM ghcr.io/zigflow/zigflow
ENV WORKFLOW_FILE=
ENV WORKFLOW_DIRECTORY=/app/workflows
ENV WORKFLOW_DIRECTORY_GLOB="**/*.{yaml,yml,json}"
COPY ./workflows /app/workflows
