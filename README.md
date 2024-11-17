# SqueakGPT

A custom GPT for ChatGPT that talks to your Squeak image.

## Setup

### Server

- Get a recent Squeak image and check out the `SqueakWorkspaceServer` package using the Git Browser.
- Start the server:

  ```smalltalk
  server := SqueakWorkspaceServer new.
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
  
> [!WARNING]  
> Remember that everybody who has access to your server can execute arbitrary code on your machine! Consider using strong authentication or keep the URL private.

### ChatGPT

- Create a [new custom GPT](https://chatgpt.com/gpts/editor) and configure it based on [`gpt.yaml`](./gpt.yaml).
- Replace `<YOUR_SERVER_URL>` by your actual server (or tunnel) URL.
- Save the GPT (but beware of making it public or sharing it with others because it exposes remote access to your local machine!) and enjoy!

## Impressions

You can read an example conversation here: <https://chatgpt.com/share/67381691-7330-8004-b515-bf5c98416cd7>

![image](https://github.com/user-attachments/assets/c0801c56-0b51-4c8e-a9f4-3efec0e36419)
![image](https://github.com/user-attachments/assets/dc16be64-0e05-4389-a303-0b94b4b73d07)
![image](https://github.com/user-attachments/assets/92021c3d-3686-47ec-8e5c-c5dd5c8229db)

