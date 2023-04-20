quartus_map --read_settings_files=on --write_settings_files=off butterfly -c butterfly
quartus_cdb --merge butterfly
quartus_fit --read_settings_files=on --write_settings_files=off butterfly -c butterfly