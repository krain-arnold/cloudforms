# This is a custom error message that logs an error to automation.log
# and changes the ae_result to error
def error(msg)
  $evm.log(:error, msg)
  $evm.root['ae_result'] = 'error'
  $evm.root['ae_reason'] = msg.to_s
  exit MIQ_OK
end

# This is a custom logging method that assumes the "info" log level
def log(msg, level = :info)
  $evm.log(level, "#{msg}")
end

# This is a good base framework for most API calls. It requires 'rest-client'.
def invoke_api(http_method, headers, user, pass, url, payload=nil) #api_timeout is another common variable. Also, depending on the use, headers could either be passed as an argument or defined inside the method itself.
#often, the url will need to be manipulated inside the method to make it flexible enough to hit different end points.  
params = {
  :method     => action,
  :url        => url,
  :headers    => headers,
  :verify_ssl => false
  }
params[:payload] = payload if payload
response = RestClient::Request.new(params).execute #it's often helpful to print out the response when debugging
return JSON.parse(response)
end
