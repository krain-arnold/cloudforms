# This is a custom error message that logs an error to automation.log
# and changes the ae_result to error
def error(msg)
  $evm.log(:error, msg)
  $evm.root['ae_result'] = 'error'
  $evm.root['ae_reason'] = msg.to_s
  exit MIQ_OK
end

# This is a custom logging method that assumes "info" level
def log(msg, level = :info)
  $evm.log(level, "#{msg}")
end

