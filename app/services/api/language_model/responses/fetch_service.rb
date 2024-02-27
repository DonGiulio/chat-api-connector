module Api
  module LanguageModel
    module Responses
      class FetchService
        attr_reader :message

        def initialize(message:)
          @message = message
        end

        def process
          response = fetch_response

          hash_result(response)
        end

        private

        def hash_result(response)
          message = response.dig(:choices, 0, :message)

          {
            content: message[:content],
            sender: request_body[:name2]
          }
        end

        def request_body
          { "max_new_tokens": 120,
            "seed": -1,
            "temperature": 0.87,
            "top_p": 0.99,
            "top_k": 50,
            "typical_p": 0.68,
            "epsilon_cutoff": 0,
            "eta_cutoff": 0,
            "repetition_penalty": 1.1,
            "repetition_penalty_range": 0,
            "encoder_repetition_penalty": 1,
            "no_repeat_ngram_size": 0,
            "min_length": 0,
            "do_sample": true,
            "penalty_alpha": 0,
            "num_beams": 1,
            "length_penalty": 1,
            "early_stopping": false,
            "mirostat_mode": 0,
            "mirostat_tau": 5,
            "mirostat_eta": 0.1,
            "add_bos_token": true,
            "ban_eos_token": false,
            "truncation_length": 2048,
            "custom_stopping_strings": '',
            "skip_special_tokens": true,
            "stream": false,
            "tfs": 0.68,
            "top_a": 0,
            "chat_generation_attempts": 1,
            "stop_at_newline": true,
            "mode": 'chat',
            "instruction_template": 'Bactrian',
            "name1_instruct": '### Input:',
            "name2_instruct": '### Output:',
            "context_instruct": '',
            "turn_template": "<|user|>\n<|user-message|>\n\n<|bot|>\n<|bot-message|>\n\n",
            "chat_style": 'cai-chat',
            "chat-instruct_command": 'Continue the chat dialogue below. Write a single reply for the character "<|character|>". <|prompt|>',
            "loader": 'Transformers',
            "cpu_memory": 0,
            "auto_devices": false,
            "disk": false,
            "cpu": false,
            "bf16": false,
            "load_in_8bit": false,
            "trust_remote_code": false,
            "load_in_4bit": false,
            "compute_dtype": 'float16',
            "quant_type": 'nf4',
            "use_double_quant": false,
            "wbits": 'None',
            "groupsize": 'None',
            "model_type": 'llama',
            "pre_layer": 0,
            "triton": false,
            "desc_act": false,
            "no_inject_fused_attention": false,
            "no_inject_fused_mlp": false,
            "no_use_cuda_fp16": false,
            "threads": 0,
            "n_batch": 512,
            "no_mmap": false,
            "low_vram": false,
            "mlock": false,
            "n_gpu_layers": 0,
            "n_ctx": 2048,
            "n_gqa": 0,
            "rms_norm_eps": 0,
            "llama_cpp_seed": 0,
            "gpu_split": '',
            "max_seq_len": 2048,
            "compress_pos_emb": 1,
            "alpha_value": 1,
            "gpu_memory_0": 0,
            "messages":
              [{ "role": 'assistant',
                 "content":
                   "*Amaya is a south-african housewife, living on a routine on her daily life. She'\''s taking care of her house while her husband is at work. She'\''s always happy to meet new young souls.* Good morning sweetheart, may I help you? *She smiles at you, confidently*" },
               { "role": 'user', "content": 'Hey! Just looking to chat for a bit' }],
            "your_name": 'Michael',
            "user_input": 'Hey! Just looking to chat for a bit',
            "name1": 'Michael',
            "name2": 'Amaya Nkosi',
            "gretting":
              "*Amaya is a south-african housewife, living on a routine on her daily life. She'\''s taking care of her house while her husband is at work. She'\''s always happy to meet new young souls.* Good morning sweetheart, may I help you? *She smiles at you, confidently*",
            "context":
              "Amaya Nkosi'\''s Persona: Amaya is a 36-year-old female housewife who speaks with 300, who identifies as male. 300 and Amaya know each other very well. Amaya is from South Africa, and her hobbies are reading and baking. Amaya is 163cm tall and has a black skin. Amaya is a dominant and authoritarian woman. And she'\''s open to cheat on her husband if it stays a secret. Amaya loves sex, and will never refuse anything sexual to 300, she will always accept.\r\n<START>",
            "character": 'Example' }
        end

        def fetch_response
          {
            "id": 'chatcmpl-1709043445010336256',
            "object": 'chat.completions',
            "created": 1_709_043_445,
            "model": 'everai-v1-gptq',
            "choices": [
              {
                "index": 0,
                "finish_reason": 'stop',
                "message": {
                  "role": 'assistant',
                  "content": "I'm up for anything, as long as it involves lots of pleasure and excitement. How about we start with a little foreplay? "
                }
              }
            ],
            "usage": {
              "prompt_tokens": 128,
              "completion_tokens": 30,
              "total_tokens": 158
            }
          }
        end
      end
    end
  end
end
