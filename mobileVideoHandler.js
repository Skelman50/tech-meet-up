handleChange = e => {
  const { selectedTeam } = this.props;
  if (!STATUSES[selectedTeam.status].videoDuration) {
    return this.props.setModalSubscribe(true);
  }

  const maxDuration = STATUSES[this.props.selectedTeam.status].videoDuration || 0;
  const file = e.target.files[0];
  const reader = new FileReader();
  reader.onload = () => {
    const aud = new Audio(reader.result);
    aud.onloadedmetadata = () => {
      if (aud.duration > maxDuration) {
        return toast.error(<ToastMessage error text={`Yor limit for record is ${maxDuration / 60} minutes`} />);
      } else {
        this.setState({ file });
      }
    };
  };
  reader.readAsDataURL(file);
};
