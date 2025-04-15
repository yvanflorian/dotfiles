# Function for nanosecond timestamps from Go's Time.UnixNano()
def format_nano_timestamp:
  (. / 1000000000) | gmtime | strftime("%Y-%m-%d %H:%M:%S");

def add_formatted_timestamps:
  if has("time") then
    . + {formatted_time: (.time | format_nano_timestamp)}
  else
    .
  end;
