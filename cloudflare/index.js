// Lastmod code at: Sat May 25 19:30:15 2024 +0800
// Created code at: 2024-05-03T15:50:44
// Original from my Codeberg repository:
// https://codeberg.org/UmmIt/worker-redirect

// A simple Cloudflare Worker that redirects 
// to a random website from a list of websites.
// The worker will redirect to the website and
// display a message to the user.

export default {
  async fetch(request) {
    const websites = [
      {
        url: "https://gitlab.com/UmmIt",
        title: "<h1>GitLab</h1>",
        devops: "GitLab"
      },
      {
        url: "https://codeberg.org/UmmIt",
        title: "<h1>Codeberg</h1>",
        devops: "Codeberg"
      },
      {
        url: "https://github.com/UmmItC",
        title: "<h1>Github</h1>",
        devops: "Github"
      }
    ];

    const statusCode = 301;

    const maxRedirects = 5;
    let redirectCount = 0;

    const randomIndex = Math.floor(Math.random() * websites.length);
    const { url, title, devops } = websites[randomIndex];

    redirectCount++;

    let redirectHTML;

    if (redirectCount <= maxRedirects) {
      redirectHTML = `
        <!DOCTYPE html>
        <html lang="en">
        <head>
          <meta charset="UTF-8">
          <meta http-equiv="refresh" content="5;url=${url}">
          <title>Redirecting...</title>
        </head>
        <body>
          <h1>${title}</h1>
          <div>
            <p>There's nothing to see at the moment, will redirect to my ${devops} ...</p>
          </div>
          <p>Redirecting to 
            <a href="${url}">${devops}</a> in 5 seconds...</p>
        </body>
        </html>
      `;
    } else {
      redirectHTML = `
        <!DOCTYPE html>
        <html lang="en">
        <head>
          <meta charset="UTF-8">
          <title>Max Redirects Reached</title>
        </head>
        <body>
          <h1>Max Redirects Reached</h1>
          <p>No more redirects allowed.</p>
        </body>
        </html>
      `;
    }

    const response = new Response(redirectHTML, {
      status: statusCode,
      headers: {
        "Content-Type": "text/html",
        "Cache-Control": "no-store, max-age=0"
      }
    });

    return response;
  },
};
