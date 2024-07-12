from langchain.schema import AIMessage, HumanMessage
import openai
import gradio as gr
import os
from gpt4all import GPT4All

llm = GPT4All("orca-mini-3b-gguf2-q4_0.gguf")

def predict(message, history):
    history_langchain_format = []
    for human, ai in history:
        history_langchain_format.append(HumanMessage(content=human))
        history_langchain_format.append(AIMessage(content=ai))
    history_langchain_format.append(HumanMessage(content=message))
    gpt_response = llm.generate(history_langchain_format, max_tokens=100)
    return gpt_response.content

gr.ChatInterface(predict).launch(server_name='0.0.0.0', server_port=8001)


