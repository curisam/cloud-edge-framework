
from langchain.chat_models import ChatOpenAI
from langchain.schema import AIMessage, HumanMessage
import openai
import gradio as gr
import os

os.environ["OPENAI_API_KEY"] = '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'
# Replace with your key

llm = ChatOpenAI(temperature=1.0)

def predict(message, history):
    history_langchain_format = []
    for human, ai in history:
        history_langchain_format.append(HumanMessage(content=human))
        history_langchain_format.append(AIMessage(content=ai))
    history_langchain_format.append(HumanMessage(content=message))
    gpt_response = llm(history_langchain_format)
    return gpt_response.content

gr.ChatInterface(predict).launch(server_name='0.0.0.0', server_port=8002)