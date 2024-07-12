import numpy as np
import gradio as gr

def flip_text(x):
    return x[::-1]

def flip_image(x):
    return np.fliplr(x)

def greet(name, intensity):
    ret = [ "Hello, " + name + "!" * int(intensity), 
            intensity,
            intensity,
          ]
    return ret

with gr.Blocks() as demo:
    gr.Markdown("# Demo Tab UI")
    
    with gr.Tabs():
        with gr.TabItem("A. 서비스 등록"):
            with gr.Tabs():
                with gr.TabItem("A1"):
                    text_input = gr.Textbox()
                    text_output = gr.Textbox()
                    text_button = gr.Button("RUN")
                    pass

                with gr.TabItem("A2"):
                    pass

        with gr.TabItem("B. 서비스 목록"):
            with gr.Tabs():
                with gr.TabItem("B1"):
                    with gr.Row():
                        image_input = gr.Image()
                        image_output = gr.Image()
                    image_button = gr.Button("Flip")
                    pass

                with gr.TabItem("B2"):
                    pass

        with gr.TabItem("C. 대상 기기"):
            with gr.Tabs():
                with gr.TabItem("C1"):
                    pass

                with gr.TabItem("C2"):
                    pass

        with gr.TabItem("D. 서비스 배포"):
            with gr.Tabs():
                with gr.TabItem("D1"):
                    pass

                with gr.TabItem("D2"):
                    pass

    text_button.click(flip_text, inputs=text_input, outputs=text_output)
    image_button.click(flip_image, inputs=image_input, outputs=image_output)
    
    gr.Markdown("# Tab UI Demo.")
    gr.Markdown("## level 2")
    gr.Markdown("### level 3")
    gr.Markdown("- Bullet")
    
    with gr.Accordion("Open for More!", open=False):
        gr.Markdown("Look at me...")
        temp_slider = gr.Slider(
            minimum=0.0,
            maximum=1.0,
            value=0.1,
            step=0.1,
            interactive=True,
            label="Slide me",
        )
        temp_slider.change(lambda x: x, [temp_slider])


demo.queue().launch(share=False,
                    debug=False,
                    server_name="0.0.0.0",
                    server_port=8001 )
