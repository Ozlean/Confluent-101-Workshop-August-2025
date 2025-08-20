#!/bin/bash


%{ for key, value in RDS1_VARS }
export ${key}=${value}
echo "${key} ${value}" >> /home/ubuntu/vars.log
%{ endfor }

%{ for key, value in RDS2_VARS }
export ${key}=${value}
echo "${key} ${value}" >> /home/ubuntu/vars.log
%{ endfor }

cd /home/ubuntu/database-application
npm run dev > /home/ubuntu/app.log 2>&1




