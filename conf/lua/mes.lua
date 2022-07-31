local json = require("json")   -- 加载json模块
local ops = require("mqOps") --加载mq操作模块

local row = ops.rawRow()  --当前数据库的一行数据,table类型，key为列名称
local action = ops.rawAction()  --当前数据库事件,包括：insert、update、delete

local id = row["id"] --获取ID列的值
local name = row["name"] --获取USER_NAME列的值

local headers = {}
local result = string.format('{"head":{}, "body" { "data": [{ "table": "res_exam", "fields": ["paper_id", "er_title"], "values": [ %d, "%s" ]}]}', id, name)

if action == "delete" -- 删除事件
then
--    local val = json.encode(result) -- 将result转为json
--    ops.SEND("user_topic",val) -- 发送消息，第一个参数为topic(string类型)，第二个参数为消息内容
else 
    ops.SEND("mes.dal.req",result) -- 发送消息，第一个参数为topic(string类型)，第二个参数为消息内容
end