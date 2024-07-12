import gradio as gr

def greet(name, intensity):
    ret = [ "Hello, " + name + "!" * int(intensity), 
            intensity,
            intensity,
          ]
    return ret

demo = gr.Interface(
    fn=greet,
    inputs=["text", "slider"],
    outputs=["text", "slider", "text"],
)

demo.queue().launch(share=False,
                    debug=False,
                    server_name="0.0.0.0",
                    server_port=8001 )

'''
demo.queue().launch(share=False,
                        debug=False,
                        server_name="0.0.0.0",
                        ssl_certfile="cert.pem",
                        ssl_keyfile="key.pem")
'''
