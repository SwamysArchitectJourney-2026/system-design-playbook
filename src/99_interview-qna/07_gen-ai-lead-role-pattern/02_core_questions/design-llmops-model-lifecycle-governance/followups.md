# Follow-ups: LLMOps and governance

## Scalability attacks

- How do **training jobs** and **inference** share **GPU** without starving production?
- **Embedding** and **batch** reprocessing at 10× data volume—what breaks?

## Failure and resilience attacks

- **Bad model** reaches 5% canary—what **automatic** rollback triggers?
- **Registry** unavailable—can anything still serve, or do you **fail closed**?

## Data and evaluation attacks

- **Training data** contained **PII**—how is the **fine-tuned** model constrained at inference?
- **Eval set** is stale; **users** shifted behavior—how do you detect?

## Security and governance attacks

- **Prompt injection** at serving time—what layers beyond the base model?
- **Who** can promote a model to **prod**—separation of duties?

## Cost attacks

- Largest model used for **every** request—your **routing** and **cache** story?
- **Storage** for checkpoints and logs—retention vs compliance?

## Leadership attacks

- **Two** VPs want different models for the **same** use case—how do you decide?
- How do you explain **why** you rejected a **full retrain** in favor of **RAG**?
