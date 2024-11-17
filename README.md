# SqueakGPT

A custom GPT for ChatGPT that talks to your Squeak image.

## Setup

### Server

- Get a recent Squeak image and check out the `SqueakWorkspaceServer` package using the Git Browser.
- Start the server:

  ```smalltalk
  server := EvalServer new.
  server startOn: 8080.
  
  "server stop."
  ```
- If you do not want to expose your own port, you can use any kind of tunnel. For example, I used [`cloudflared`](https://github.com/cloudflare/cloudflared):

  ```bash
  cloudflared tunnel --url http://localhost:8080
  ```
  
  If you use a tunnel, you must specify the public tunnel URL to the server:
  
  ```smalltalk
  server tunnelServerUrl: 'https://your-unique-tunnel-name.trycloudflare.com'.
  ```
  
> **Warning**  
> Remember that everybody who has access to your server can execute arbitrary code on your machine! Consider using strong authentication or keep the URL private.

### ChatGPT

- Create a [new custom GPT](https://chatgpt.com/gpts/editor) and configure it based on [`gpt.yaml`](./gpt.yaml).
- Replace `<YOUR_SERVER_URL>` by your actual server (or tunnel) URL.
- Save the GPT (but beware of making it public or sharing it with others because it exposes remote access to your local machine!) and enjoy!
