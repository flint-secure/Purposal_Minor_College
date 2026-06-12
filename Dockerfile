# Stage 1: Build LaTeX PDF
FROM texlive/texlive:latest AS builder

# Install fontconfig
RUN apt-get update && apt-get install -y --no-install-recommends fontconfig && rm -rf /var/lib/apt/lists/*

# Copy the Times New Roman fonts copied from Windows and update font cache
COPY fonts/*.ttf /usr/share/fonts/truetype/msttcorefonts/
RUN fc-cache -f -v

# Set working directory
WORKDIR /workspace

# Copy files required for compilation
COPY proposal.tex ncitproject.cls college_logo.png ./
COPY sections/ ./sections/
COPY figures/ ./figures/

# Compile the LaTeX document multiple times to resolve citations, links, and page references
RUN xelatex -interaction=nonstopmode -halt-on-error -file-line-error proposal.tex \
    && xelatex -interaction=nonstopmode -halt-on-error -file-line-error proposal.tex \
    && xelatex -interaction=nonstopmode -halt-on-error -file-line-error proposal.tex

# Stage 2: Export output PDF
FROM scratch AS exporter
COPY --from=builder /workspace/proposal.pdf /
