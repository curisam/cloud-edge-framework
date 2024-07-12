import gradio as gr


demo = gr.Blocks()

with demo:
    with gr.Tabs():
        with gr.TabItem("AAA"):
            with gr.Tabs():
                with gr.TabItem("111"):
                    pass

                with gr.TabItem("222"):
                    pass

        with gr.TabItem("BBB"):
            with gr.Tabs():
                with gr.TabItem("111"):
                    pass

                with gr.TabItem("222"):
                    pass

demo.queue().launch(share=False,
                    debug=False,
                    server_name="0.0.0.0",
                    server_port=8001 )
