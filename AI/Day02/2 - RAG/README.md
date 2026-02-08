# RAG (Retrieval Augmented Generation) 🔍

Discover how to build a complete RAG system that gives an LLM access to your own documents to answer questions with accurate, sourced information.

You will:
- Understand and create text embeddings with Sentence-Transformers
- Measure semantic similarity between texts using cosine similarity
- Visualize embeddings in 2D with PCA
- Build a vector database with ChromaDB
- Build a full RAG pipeline (Retrieve, Augment, Generate) with Ollama
- Implement document chunking for real-world documents

## What is RAG?

RAG (Retrieval Augmented Generation) is a technique that enhances an LLM by giving it access to external documents at query time. Instead of modifying the model's weights (like fine-tuning), we **search for relevant information** in a knowledge base and provide it as context to the model.

Think of it this way:
- **Fine-tuning** = Teaching a student new facts by heart (slow, expensive, hard to update)
- **RAG** = Giving the student access to a library and teaching them how to search (fast, flexible, always up-to-date)

In this workshop, you'll build a RAG system over documents about a fictional company (TechCorp) using embeddings, ChromaDB, and a local LLM via Ollama.

## Documentation

- [Sentence-Transformers Documentation](https://www.sbert.net/)
- [ChromaDB Documentation](https://docs.trychroma.com/)
- [Ollama API Documentation](https://github.com/ollama/ollama/blob/main/docs/api.md)
- [Scikit-learn PCA](https://scikit-learn.org/stable/modules/generated/sklearn.decomposition.PCA.html)

## Getting Started

### Prerequisites

- Python 3.7+
- Jupyter Notebook installed
- Basic understanding of Python and machine learning concepts
- [Ollama](https://ollama.com/) installed on your machine

### Installation

Install the required packages:

```bash
pip install sentence-transformers chromadb numpy matplotlib scikit-learn requests
```

Or use the installation cells in the notebook.

### Ollama Setup

1. Install Ollama from [ollama.com](https://ollama.com/)
2. Pull the model:
```bash
ollama pull llama3.2:3b
```
3. Keep Ollama running in the background:
```bash
ollama serve
```

Please open the `rag_afternoon.ipynb` file to get started.

## Workshop Structure

1. **Understanding Embeddings**: Create text embeddings and measure semantic similarity
2. **Visualize Embeddings**: Use PCA to see how embeddings cluster by meaning
3. **Building a Vector Database**: Store and search documents with ChromaDB
4. **Building a RAG System**: Combine retrieval + LLM generation into a full pipeline
5. **RAG on Real Documents**: Implement chunking and build RAG over multi-file documents

## Next Steps

After completing this workshop, you can:
- Build a RAG system with your own documents (PDFs, web pages, etc.)
- Try different embedding models and compare retrieval quality
- Experiment with different chunk sizes and overlaps
- Combine RAG with fine-tuning for production-ready AI systems

## Author

This workshop introduces RAG techniques for giving LLMs access to external knowledge without retraining.

<h2 align=center>
Organization
</h2>
<br/>
<p align='center'>
    <a href="https://www.linkedin.com/company/pocinnovation/mycompany/">
        <img src="https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white" alt="LinkedIn logo">
    </a>
    <a href="https://www.instagram.com/pocinnovation/">
        <img src="https://img.shields.io/badge/Instagram-E4405F?style=for-the-badge&logo=instagram&logoColor=white" alt="Instagram logo"
>
    </a>
    <a href="https://twitter.com/PoCInnovation">
        <img src="https://img.shields.io/badge/Twitter-1DA1F2?style=for-the-badge&logo=twitter&logoColor=white" alt="Twitter logo">
    </a>
    <a href="https://discord.com/invite/Yqq2ADGDS7">
        <img src="https://img.shields.io/badge/Discord-7289DA?style=for-the-badge&logo=discord&logoColor=white" alt="Discord logo">
    </a>
</p>
<p align=center>
    <a href="https://www.poc-innovation.fr/">
        <img src="https://img.shields.io/badge/WebSite-1a2b6d?style=for-the-badge&logo=GitHub Sponsors&logoColor=white" alt="Website logo">
    </a>
</p>

> 🚀 Don't hesitate to follow us on our different networks, and put a star 🌟 on `PoC's` repositories.
