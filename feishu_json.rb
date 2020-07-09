
a = {
    "open_id": "ou_dbda6b5c3078b57dc8707200eb1e67c7",
    "msg_type": "interactive",
    "card": {
        "elements": [
            {
                "tag": "action",
                "actions": [
                    {
                        "tag": "select_static",
                        "placeholder": {
                            "tag": "plain_text",
                            "content": " Option mode - Less Option"
                        },
                        "options": [
                            {
                                "text": {
                                    "tag": "plain_text",
                                    "content": " Option-1"
                                },
                                "value": "option_1"
                            },
                            {
                                "text": {
                                    "tag": "plain_text",
                                    "content": " Option-2"
                                },
                                "value": "option_2"
                            },
                            {
                                "text": {
                                    "tag": "plain_text",
                                    "content": " Option-3"
                                },
                                "value": "option_3"
                            },
                            {
                                "text": {
                                    "tag": "plain_text",
                                    "content": " Option-4"
                                },
                                "value": "option_4"
                            }
                        ],
                        "value": {
                          "option_1": 1,
                          "option_2": 1,
                          "option_3": 1,
                          "option_4": 1
                        }
                    }
                ]
            }
        ]
    }
}

puts a


message.instance_eval do
  def payload
    {:open_id=>"ou_dbda6b5c3078b57dc8707200eb1e67c7", :msg_type=>"interactive", :card=>{:elements=>[{:tag=>"action", :actions=>[{:tag=>"select_static", :placeholder=>{:tag=>"plain_text", :content=>" Option mode - Less Option"}, :options=>[{:text=>{:tag=>"plain_text", :content=>" Option-1"}, :value=>"option_1"}, {:text=>{:tag=>"plain_text", :content=>" Option-2"}, :value=>"option_2"}, {:text=>{:tag=>"plain_text", :content=>" Option-3"}, :value=>"option_3"}, {:text=>{:tag=>"plain_text", :content=>" Option-4"}, :value=>"option_4"}], :value=>{:option_1=>1, :option_2=>1, :option_3=>1, :option_4=>1}}]}]}}.to_json
  end
end
{
    "open_id": "ou_dbda6b5c3078b57dc8707200eb1e67c7",
    "msg_type": "interactive",
    "card": {
        "elements": [
            {
                "tag": "div",
                "text": {
                    "tag": "plain_text",
                    "content": "overflow element"
                }
            },
            {
                "tag": "hr"
            },
            {
                "tag": "action",
                "actions": [
                    {
                        "tag": "overflow",
                        "content": "添加。。。",
                        "options": [
                            {
                                "text": {
                                    "tag": "plain_text",
                                    "content": "Option-1"
                                },
                                "value": { "ticket_id": 1 }
                            },
                            {
                                "text": {
                                    "tag": "plain_text",
                                    "content": " Option-2"
                                },
                                "value": { "ticket_id": 2 }
                            },
                            {
                                "text": {
                                    "tag": "plain_text",
                                    "content": " Option-3"
                                },
                                "value": { "ticket_id": 3 }
                            }
                        ]
                    }
                ]
            }
        ]
    }
}.to_json
