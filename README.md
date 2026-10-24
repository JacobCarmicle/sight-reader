# Sight Reader

A microphone-based sight-reading drill for piano. Shows a note, listens, and moves
on when you play the right one.

## Run it with Docker Desktop

From this folder, once:

```bash
docker compose up -d --build
```

Then open **http://localhost:8080**

After that first build, the container shows up in Docker Desktop under
**Containers** as `sight-reader`. Use the ▶ / ■ buttons to start and stop it, and
click the `8080:80` port link to open it in your browser. It is set to
`restart: unless-stopped`, so it comes back on its own after a reboot or a Docker
Desktop restart.

### Open it as `localhost`, not a LAN address

Browsers only hand out the microphone on a *secure context*. `http://localhost:8080`
counts as one; `http://192.168.x.x:8080` or a machine name does not — the page will
load but the mic will never start. If you want to use it from another device on
your network you'd need HTTPS with a real certificate.

### Changing the port

Edit the left-hand number in `compose.yaml`, then `docker compose up -d`:

```yaml
ports:
  - "8080:80"     # host:container — change 8080 to whatever you like
```

### After editing index.html

The file is copied into the image at build time, so rebuild:

```bash
docker compose up -d --build
```

If you're making lots of edits, uncomment the `volumes:` block in `compose.yaml`
instead — then the file is mounted live and a browser refresh is enough.

## Running without Docker

It's a single self-contained HTML file. Any static server works:

```bash
python3 -m http.server 8080
```

Opening `index.html` directly as a `file://` URL will **not** work — `getUserMedia`
requires http(s) on localhost.

## Notes

- VexFlow is loaded from a CDN, so the page needs internet access on first load.
- Detection is monophonic: one note at a time, no chords.
