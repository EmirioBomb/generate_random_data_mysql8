# generate random data on mysql8
> generate simple but non-standard data on mysql
> generate multiple rows with random data

`available columns`
* chinese_name
* sex
* birthday
* age
* phone_number
* chinese_address
* salary
* email
* chinese_job
* status
* entry_time
* modify_tim
  
`efficiency improvement`
* create batch prepare statement
* commit transaction
* insert into with multi values like values(), (), ()...
