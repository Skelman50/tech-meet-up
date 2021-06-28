<Videojs
  {...videoJsOptions}
  sources={{
    src: window.URL.createObjectURL(file),
    type: "video/mp4",
  }}
/>;
