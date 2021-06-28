<MobileRecorderRoot>
  <MobileRecorderInner>
    <Camera color="#1ab6c0" />
    <Text>{i18n.addResponse}</Text>
    <input
      type="file"
      accept="video/*,video/mp4;capture=camcorder"
      onChange={handleChange}
      capture
      id="video-capture-file"
      style={{ display: "none" }}
      ref={inputRef}
    />
  </MobileRecorderInner>
  <Controls>
    <MobileRecorderLabel htmlFor="video-capture-file">
      <span style={{ marginRight: "8px" }}>{i18n.cameraRecordStart}</span>
      <Camera color="#9513ff" />
    </MobileRecorderLabel>
  </Controls>
</MobileRecorderRoot>;
