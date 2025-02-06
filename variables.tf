variable "name_prefix" {
  description = "This value is appended at the beginning of resource names."
  type        = string
  default     = "BedrockAgents"
}

# – Bedrock Agent –
variable "agent_name" {
  description = "The name of your agent."
  type        = string
  default     = "TerraformBedrockAgents"
}

variable "create_agent" {
  description = "Whether or not to deploy an agent."
  type        = bool
  default     = true
}

variable "foundation_model" {
  description = "The foundation model for the Bedrock agent."
  type        = string
  default     = null
}

# instruction must be greater than 40 characters
variable "instruction" {
  description = "A narrative instruction to provide the agent as context."
  type        = string
  default     = ""

  validation {
    condition     = length(var.instruction) == 0 || length(var.instruction) >= 40 
    error_message = "Instruction string length must be at least 40."
  }
}

variable "agent_description" {
  description = "A description of agent."
  type        = string
  default     = null
}

variable "idle_session_ttl" {
  description = "How long sessions should be kept open for the agent."
  type        = number
  default     = 600
}

variable "kms_key_arn" {
  description = "KMS encryption key to use for the agent."
  type        = string
  default     = null
}

variable "tags" {
  description = "Tag bedrock agent resource."
  type        = map(string)
  default     = null
}

# – Prompt Override Configuartion –
variable "prompt_override" {
  description = "Whether to provide prompt override configuration."
  type        = bool
  default     = false
}

variable "prompt_type" {
  description = "The step in the agent sequence that this prompt configuration applies to."
  type        = string
  default     = null

  validation {
    condition     = var.prompt_type == "PRE_PROCESSING" || var.prompt_type == "ORCHESTRATION" || var.prompt_type == "POST_PROCESSING" || var.prompt_type == "KNOWLEDGE_BASE_RESPONSE_GENERATION" || var.prompt_type == null
    error_message = "Not a valid prompt_type."
  }
}

# must contain non-whitespace characters
variable "base_prompt_template" {
  description = "Defines the prompt template with which to replace the default prompt template."
  type        = string
  default     = null
}

variable "parser_mode" {
  description = "Specifies whether to override the default parser Lambda function."
  type        = string
  default     = null

  validation {
    condition     = var.parser_mode == "DEFAULT" || var.parser_mode == "OVERRIDDEN" || var.parser_mode == null
    error_message = "The parser_mode must be set to DEFAULT or OVERRIDDEN."
  }
}

variable "prompt_creation_mode" {
  description = "Specifies whether to override the default prompt template."
  type        = string
  default     = null

  validation {
    condition     = var.prompt_creation_mode == "DEFAULT" || var.prompt_creation_mode == "OVERRIDDEN" || var.prompt_creation_mode == null
    error_message = "The prompt_creation_mode must be set to DEFAULT or OVERRIDDEN."
  }
}

variable "prompt_state" {
  description = "Specifies whether to allow the agent to carry out the step specified in the promptType."
  type        = string
  default     = null

  validation {
    condition     = var.prompt_state == "ENABLED" || var.prompt_state == "DISABLED" || var.prompt_state == null
    error_message = "The prompt_state must be set to ENABLED or DISABLED."
  }
}

variable "override_lambda_arn" {
  description = "The ARN of the Lambda function to use when parsing the raw foundation model output in parts of the agent sequence."
  type        = string
  default     = null
}

# – Inference Configuration –

variable "temperature" {
  description = "The likelihood of the model selecting higher-probability options while generating a response."
  type        = number
  default     = 0

  validation {
    condition     = var.temperature >= 0 && var.temperature <= 1
    error_message = "The temperature must be between 0 and 1."
  }
}

variable "top_p" {
  description = "Cumulative probability cutoff for token selection."
  type        = number
  default     = 0.50

  validation {
    condition     = var.top_p >= 0 && var.top_p <= 1.00
    error_message = "The top_p must be between 0 and 1.00."
  }
}

variable "top_k" {
  description = "Sample from the k most likely next tokens."
  type        = number
  default     = 50

  validation {
    condition     = var.top_k >= 0 && var.top_k <= 500
    error_message = "The top_k must be between 0 and 500."
  }
}

variable "stop_sequences" {
  description = "A list of stop sequences."
  type        = list(string)
  default     = []

  validation {
    condition     = length(var.stop_sequences) >= 0 && length(var.stop_sequences) <= 4
    error_message = "The stop_sequences length must be between 0 and 4."
  }
}

variable "max_length" {
  description = "The maximum number of tokens to generate in the response."
  type        = number
  default     = 0

  validation {
    condition     = var.max_length >= 0 && var.max_length <= 4096
    error_message = "The max_length must be between 0 and 4096."
  }
}

# – Agent Alias – 

variable "create_agent_alias" {
  description = "Whether or not to create an agent alias."
  type        = bool
  default     = false
}

variable "agent_alias_name" {
  description = "The name of the guardrail."
  type        = string
  default     = "TerraformBedrockAgentAlias"
}

variable "agent_id" {
  description = "Agent identifier."
  type        = string
  default     = null
}

variable "agent_alias_description" {
  description = "Description of the agent alias."
  type        = string
  default     = null
}

variable "bedrock_agent_version" {
  description = "Agent version."
  type        = string
  default     = null
}

variable "agent_alias_tags" {
  description = "Tag bedrock agent alias resource."
  type        = map(string)
  default     = null
}

# – Agent Collaborator – 

variable "create_collaborator" {
  description = "Whether or not to create an agent collaborator."
  type        = bool
  default     = false
}

variable "collaboration_instruction" {
  description = "Instruction to give the collaborator."
  type        = string
  default     = null
}

variable "collaborator_name" {
  description = "The name of the collaborator."
  type        = string
  default     = "TerraformBedrockAgentCollaborator"
}

variable "supervisor_name" {
  description = "The name of the supervisor."
  type        = string
  default     = "TerraformBedrockAgentSupervisor"
}


variable "supervisor_idle_session_ttl" {
  description = "How long sessions should be kept open for the supervisor agent."
  type        = number
  default     = 600
}

variable "supervisor_model" {
  description = "The foundation model for the Bedrock supervisor agent."
  type        = string
  default     = null
}

variable "supervisor_instruction" {
  description = "A narrative instruction to provide the agent as context."
  type        = string
  default     = ""

  validation {
    condition     = length(var.supervisor_instruction) == 0 || length(var.supervisor_instruction) >= 40 
    error_message = "Instruction string length must be at least 40."
  }
}

variable "agent_collaboration" {
  description = "Agents collaboration role."
  type        = string
  default     = "SUPERVISOR"
  
  validation {
    condition     = var.agent_collaboration == "SUPERVISOR" || var.agent_collaboration == "SUPERVISOR_ROUTER"
    error_message = "Valid values: SUPERVISOR or SUPERVISOR_ROUTER"
  } 
}

variable "supervisor_kms_key_arn" {
  description = "KMS encryption key to use for the supervisor agent."
  type        = string
  default     = null
}

variable "create_supervisor_guardrail" {
  description = "Whether or not to create a guardrail for the supervisor agent."
  type        = bool
  default     = false
}

variable "supervisor_guardrail_id" {
  description = "The ID of the guardrail for the supervisor agent."
  type        = string
  default     = null
}

variable "supervisor_guardrail_version" {
  description = "The version of the guardrail for the supervisor agent."
  type        = string
  default     = null
}

# – Guardrails –

variable "create_guardrail" {
  description = "Whether or not to create a guardrail."
  type        = bool
  default     = false
}

variable "guardrail_name" {
  description = "The name of the guardrail."
  type        = string
  default     = "TerraformBedrockGuardrail"
}

variable "blocked_input_messaging" {
  description = "Messaging for when violations are detected in text."
  type        = string
  default     = "Blocked input"
}

variable "blocked_outputs_messaging" {
  description = "Messaging for when violations are detected in text."
  type        = string
  default     = "Blocked output"
}

variable "guardrail_description" {
  description = "Description of the guardrail."
  type        = string
  default     = null
}

variable "filters_config" {
  description = "List of content filter configs in content policy."
  type        = list(map(string))
  default     = null
}

variable "pii_entities_config" {
  description = "List of entities."
  type        = list(map(string))
  default     = null
}

variable "regexes_config" {
  description = "List of regex."
  type        = list(map(string))
  default     = null
}

variable "managed_word_lists_config" {
  description = "A config for the list of managed words."
  type        = list(map(string))
  default     = null
}

variable "words_config" {
  description = "List of custom word configs."
  type        = list(map(string))
  default     = null
}

variable "topics_config" {
  description = "List of topic configs in topic policy"
  type = list(object({
    name       = string
    examples   = list(string)
    type       = string
    definition = string
  }))
  default = null
}

variable "guardrail_tags" {
  description = "A map of tags keys and values for the knowledge base."
  type        = list(map(string))
  default     = null
}

variable "guardrail_kms_key_arn" {
  description = "KMS encryption key to use for the guardrail."
  type        = string
  default     = null
}


# – Knowledge Base –

variable "existing_kb" {
  description = "The ID of the existing knowledge base."
  type        = string
  default     = null
}

variable "create_kb" {
  description = "Whether or not to attach a knowledge base."
  type        = bool
  default     = false
}

variable "create_default_kb" {
  description = "Whether or not to create the default knowledge base."
  type        = bool
  default     = false
}

# – S3 Data Source –

variable "create_s3_data_source" {
  description = "Whether or not to create the S3 data source."
  type        = bool
  default     = false
}

variable "kb_s3_data_source" {
  description = "The S3 data source ARN for the knowledge base."
  type        = string
  default     = null
}

variable "kb_s3_data_source_kms_arn" {
  description = "The ARN of the KMS key used to encrypt S3 content"
  type        = string
  default     = null
}

variable "bucket_owner_account_id" {
  description = "Bucket account owner ID for the S3 bucket."
  type        = string
  default     = null
}

variable "s3_inclusion_prefixes" {
  description = "List of S3 prefixes that define the object containing the data sources."
  type        = list(string)
  default     = null
}

# – Web Crawler Data Source – 

variable "create_web_crawler" {
  description = "Whether or not create a web crawler data source."
  type        = bool
  default     = false
}

variable "rate_limit" {
  description = "Rate of web URLs retrieved per minute."
  type        = number
  default     = null
}

variable "exclusion_filters" {
  description = "A set of regular expression filter patterns for a type of object."
  type        = list(string)
  default     = []
}

variable "inclusion_filters" {
  description = "A set of regular expression filter patterns for a type of object."
  type        = list(string)
  default     = []
}

variable "crawler_scope" {
  description = "The scope that a web crawl job will be restricted to."
  type        = string
  default     = null
}

variable "seed_urls" {
  description = "A list of web urls."
  type        = list(object({url = string}))
  default     = []
}

# – Confluence Data Source – 

variable "create_confluence" {
  description = "Whether or not create a Confluence data source."
  type        = bool
  default     = false
}

variable "pattern_object_filter_list" {
  description = "List of pattern object information."
  type        = list(object({
    exclusion_filters = optional(list(string))
    inclusion_filters = optional(list(string))
    object_type       = optional(string)

  }))
  default     = []
}

variable "crawl_filter_type" {
  description = "The crawl filter type."
  type        = string
  default     = null
}

variable "auth_type" {
  description = "The supported authentication type."
  type        = string
  default     = null
}

variable "confluence_credentials_secret_arn" {
  description = "The ARN of an AWS Secrets Manager secret that stores your authentication credentials for your Confluence instance URL."
  type        = string
  default     = null
}

variable "host_type" {
  description = "The supported host type, whether online/cloud or server/on-premises."
  type        = string
  default     = null
}

variable "host_url" {
  description = "The host URL or instance URL."
  type        = string
  default     = null
}

# – Sharepoint Data Source – 

variable "create_sharepoint" {
  description = "Whether or not create a Share Point data source."
  type        = bool
  default     = false
}

variable "share_point_credentials_secret_arn" {
  description = "The ARN of an AWS Secrets Manager secret that stores your authentication credentials for your SharePoint site/sites."
  type        = string
  default     = null
}

variable "share_point_domain" {
  description = "The domain of your SharePoint instance or site URL/URLs."
  type        = string
  default     = null
}

variable "share_point_site_urls" {
  description = "A list of one or more SharePoint site URLs."
  type        = list(string)
  default     = []
}

variable "tenant_id" {
  description = "The identifier of your Microsoft 365 tenant."
  type        = string
  default     = null
}

# – Salesforce Data Source –

variable "create_salesforce" {
  description = "Whether or not create a Salesforce data source."
  type        = bool
  default     = false
}

variable "salesforce_credentials_secret_arn" {
  description = "The ARN of an AWS Secrets Manager secret that stores your authentication credentials for your Salesforce instance URL."
  type        = string
  default     = null
}

# – Data Source Vector Ingestion – 

variable "create_vector_ingestion_configuration" {
  description = "Whether or not to create a vector ingestion configuration."
  type        = bool
  default     = false
}

variable "create_custom_tranformation_config" {
  description = "Whether or not to create a custom transformation configuration."
  type        = bool
  default     = false
}

variable "create_parsing_configuration" {
  description = "Whether or not to create a parsing configuration."
  type        = bool
  default     = false
}

variable "chunking_strategy" {
  description = "Knowledge base can split your source data into chunks. A chunk refers to an excerpt from a data source that is returned when the knowledge base that it belongs to is queried. You have the following options for chunking your data. If you opt for NONE, then you may want to pre-process your files by splitting them up such that each file corresponds to a chunk."
  type        = string
  default     = null
}

variable "chunking_strategy_max_tokens" {
  description = "The maximum number of tokens to include in a chunk."
  type        = number
  default     = null
}

variable "chunking_strategy_overlap_percentage" {
  description = "The percentage of overlap between adjacent chunks of a data source."
  type        = number
  default     = null
}

variable "level_configurations_list" {
  description = "Token settings for each layer."
  type        = list(object({ max_tokens = number }))
  default     = null
}

variable "heirarchical_overlap_tokens" {
  description = "The number of tokens to repeat across chunks in the same layer."
  type        = number
  default     = null
}

variable "breakpoint_percentile_threshold" {
  description = "The dissimilarity threshold for splitting chunks."
  type        = number
  default     = null
}

variable "semantic_buffer_size" {
  description = "The buffer size."
  type        = number
  default     = null
}

variable "semantic_max_tokens" {
  description = "The maximum number of tokens that a chunk can contain."
  type        = number
  default     = null
}

variable "s3_location_uri" {
  description = "A location for storing content from data sources temporarily as it is processed by custom components in the ingestion pipeline."
  type        = string
  default     = null
}

variable "transformations_list" {
  description = "A list of Lambda functions that process documents."
  type        = list(object({
                  step_to_apply = optional(string)
                  transformation_function = optional(object({
                    transformation_lambda_configuration = optional(object({
                      lambda_arn = optional(string)
                    }))
                  }))
                }))
  default     = null
}

variable "parsing_config_model_arn" {
  description = "The model's ARN."
  type        = string
  default     = null
}

variable "parsing_prompt_text" {
  description = "Instructions for interpreting the contents of a document."
  type        = string
  default     = null
}

variable "parsing_strategy" {
  description = "The parsing strategy for the data source."
  type        = string
  default     = null
}

# – Knowledge base – 

variable "kb_name" {
  description = "Name of the knowledge base."
  type        = string
  default     = "knowledge-base"
}

variable "kb_tags" {
  description = "A map of tags keys and values for the knowledge base."
  type        = map(string)
  default     = null
}

variable "vector_index_name" {
  description = "The name of the vector index."
  type        = string
  default     = "bedrock-knowledge-base-default-index"
}

variable "metadata_field" {
  description = "The name of the field in which Amazon Bedrock stores metadata about the vector store."
  type        = string
  default     = "AMAZON_BEDROCK_METADATA"
}

variable "text_field" {
  description = "The name of the field in which Amazon Bedrock stores the raw text from your data."
  type        = string
  default     = "AMAZON_BEDROCK_TEXT_CHUNK"
}

variable "vector_field" {
  description = "The name of the field where the vector embeddings are stored"
  type        = string
  default     = "bedrock-knowledge-base-default-vector"
}

variable "collection_arn" {
  description = "The ARN of the collection."
  type        = string
  default     = null
}

variable "collection_name" {
  description = "The name of the collection."
  type        = string
  default     = null
}

variable "kb_role_arn" {
  description = "The ARN of the IAM role with permission to invoke API operations on the knowledge base."
  type        = string
  default     = null
}

variable "kb_description" {
  description = "Description of knowledge base."
  type        = string
  default     = "Terraform deployed Knowledge Base"
}

variable "kb_type" {
  description = "The type of a knowledge base."
  type        = string
  default     = null
}

variable "kb_embedding_model_arn" {
  description = "The ARN of the model used to create vector embeddings for the knowledge base."
  type        = string
  default     = "arn:aws:bedrock:us-east-1::foundation-model/amazon.titan-embed-text-v1"
}

variable "kb_storage_type" {
  description = "The storage type of a knowledge base."
  type        = string
  default     = null
}

variable "kb_state" {
  description = "State of knowledge base; whether it is enabled or disabled"
  type        = string
  default     = "ENABLED"

  validation {
    condition     = var.kb_state == "ENABLED" || var.kb_state == "DISABLED"
    error_message = "Not a valid kb_state."
  }
}

variable "credentials_secret_arn" {
  description = "The ARN of the secret in Secrets Manager that is linked to your database"
  type        = string
  default     = null
}

variable "database_name" {
  description = "Name of the database."
  type        = string
  default     = null
}

variable "endpoint" {
  description = "Database endpoint"
  type        = string
  default     = null
}

variable "kb_monitoring_arn" {
  description = "The ARN of the target for delivery of knowledge base application logs"
  type        = string
  default     = null
}

variable "create_kb_log_group" {
  description = "Whether or not to create a log group for the knowledge base."
  type        = bool
  default     = false
}

variable "kb_log_group_retention_in_days" {
  description = "The retention period of the knowledge base log group."
  type        = number
  default     = 0
  validation {
    condition     = contains([1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1096, 1827, 2192, 2557, 2922, 3288, 3653, 0], var.kb_log_group_retention_in_days)
    error_message = "The provided retention period is not a valid CloudWatch logs retention period."
  }
}

# – MongoDB Atlas Configuration –

variable "create_mongo_config" {
  description = "Whether or not to use MongoDB Atlas configuration"
  type        = bool
  default     = false
}

variable "endpoint_service_name" {
  description = "MongoDB Atlas endpoint service name."
  type        = string
  default     = null
}


# – Opensearch Serverless Configuration –
# the default vector database

variable "create_opensearch_config" {
  description = "Whether or not to use Opensearch Serverless configuration"
  type        = bool
  default     = false
}

# – Pinecone Configuration –

variable "create_pinecone_config" {
  description = "Whether or not to use Pinecone configuration"
  type        = bool
  default     = false
}

variable "connection_string" {
  description = "The endpoint URL for your index management page."
  type        = string
  default     = null
}

variable "namespace" {
  description = "The namespace to be used to write new data to your pinecone database"
  type        = string
  default     = null
}

# – RDS Configuration –

variable "create_rds_config" {
  description = "Whether or not to use RDS configuration"
  type        = bool
  default     = false
}

variable "resource_arn" {
  description = "The ARN of the vector store."
  type        = string
  default     = null
}

variable "table_name" {
  description = "The name of the table in the database."
  type        = string
  default     = null
}

variable "primary_key_field" {
  description = "The name of the field in which Bedrock stores the ID for each entry."
  type        = string
  default     = null
}

# – Action Group –

variable "create_ag" {
  description = "Whether or not to create an action group."
  type        = bool
  default     = false
}

variable "action_group_name" {
  description = "Name of the action group."
  type        = string
  default     = null
}

variable "action_group_state" {
  description = "State of the action group."
  type        = string
  default     = null
}

variable "action_group_description" {
  description = "Description of the action group."
  type        = string
  default     = null
}

variable "parent_action_group_signature" {
  description = "Action group signature for a builtin action."
  type        = string
  default     = null
}

variable "skip_resource_in_use" {
  description = "Specifies whether to allow deleting action group while it is in use."
  type        = bool
  default     = null
}

# – Action Group Executor –

variable "custom_control" {
  description = "Custom control of action execution."
  type        = string
  default     = null
}

variable "lambda_action_group_executor" {
  description = "ARN of Lambda."
  type        = string
  default     = null
}

# – Action Group API Schema –

variable "api_schema_payload" {
  description = "String OpenAPI Payload."
  type        = string
  default     = null
}

variable "api_schema_s3_bucket_name" {
  description = "A bucket in S3."
  type        = string
  default     = null
}

variable "api_schema_s3_object_key" {
  description = "An object key in S3."
  type        = string
  default     = null
}

# – Prompt Management – 

variable "prompt_name" {
  description = "Name for a prompt resource."
  type        = string
  default     = null
}

variable "prompt_description" {
  description = "Description for a prompt resource."
  type        = string
  default     = null
}

variable "customer_encryption_key_arn" {
  description = "A KMS key ARN."
  type        = string
  default     = null
}

variable "default_variant" {
  description = "Name for a variant."
  type        = string
  default     = null
}

variable "create_prompt" {
  description = "Whether or not to create a prompt resource."
  type        = bool
  default     = false
}

variable "prompt_tags" {
  description = "A map of tag keys and values for prompt resource."
  type        = map(string)
  default     = null
}

variable "variants_list" {
  description = "List of prompt variants."
  type = list(object({
    name                    = optional(string)
    template_type           = optional(string)
    model_id                = optional(string)
    inference_configuration = optional(object({
                                text = optional(object({
                                  max_tokens = optional(number)
                                  stop_sequences = optional(list(string))
                                  temperature = optional(number)
                                  top_p = optional(number)
                                }))
                              }))

    template_configuration  = optional(object({
                                text = optional(object({
                                  input_variables = optional(list(object({ name = optional(string) })))
                                  text = optional(string)
                                  text_s3_location = optional(object({
                                    bucket = optional(string)
                                    key = optional(string)
                                    version = optional(string)
                                  }))
                                }))
                              }))
  }))
  default = null
}

variable "create_prompt_version" {
  description = "Whether or not to create a prompt version."
  type        = bool
  default     = false
}

variable "prompt_version_description" {
  description = "Description for a prompt version resource."
  type        = string
  default     = null
}

variable "prompt_version_tags" {
  description = "A map of tag keys and values for a prompt version resource."
  type        = map(string)
  default     = null
}

# – Application Inference Profile –

variable "create_app_inference_profile" {
  description = "Whether or not to create an application inference profile."
  type        = bool
  default     = false
}

variable "app_inference_profile_name" {
  description = "The name of your application inference profile."
  type        = string
  default     = "AppInferenceProfile"
}

variable "app_inference_profile_description" {
  description = "A description of application inference profile."
  type        = string
  default     = null
}

variable "app_inference_profile_model_source" {
  description = "Source arns for a custom inference profile to copy its regional load balancing config from. This can either be a foundation model or predefined inference profile ARN."
  type        = string
  default     = null
}

variable "app_inference_profile_tags" {
  description = "A map of tag keys and values for application inference profile."
  type        = list(map(string))
  default     = null
}

# – Bedrock Flow – 

variable "create_flow_alias" {
  description = "Whether or not to create a flow alias resource."
  type        = bool
  default     = false
}

variable "flow_alias_name" {
  description = "The name of your flow alias."
  type        = string
  default     = "BedrockFlowAlias"
}

variable "flow_arn" {
  description = "ARN representation of the flow."
  type        = string
  default     = null
}

variable "flow_alias_description" {
  description = "A description of the flow alias."
  type        = string
  default     = null
}

variable "flow_version" {
  description = "Version of the flow."
  type        = string
  default     = null
}

variable "flow_version_description" {
  description = "A description of flow version."
  type        = string
  default     = null
}

# – Custom Model – 

variable "create_custom_model" {
  description = "Whether or not to create a custom model."
  type        = bool
  default     = false
}

variable "custom_model_id" {
  description = "The base model id for a custom model."
  type        = string
  default     = "amazon.titan-text-express-v1"
}

variable "custom_model_name" {
  description = "Name for the custom model."
  type        = string
  default     = "custom-model"
}

variable "custom_model_job_name" {
  description = "A name for the model customization job."
  type        = string
  default     = "custom-model-job"
}

variable "custom_model_kms_key_id" {
  description = "The custom model is encrypted at rest using this key. Specify the key ARN."
  type        = string
  default     = null
}

variable "customization_type" {
  description = "The customization type. Valid values: FINE_TUNING, CONTINUED_PRE_TRAINING."
  type        = string
  default     = "FINE_TUNING"

  validation {
    condition     = var.customization_type == "FINE_TUNING" || var.customization_type == "CONTINUED_PRE_TRAINING"
    error_message = "Customization type valid values are FINE_TUNING or CONTINUED_PRE_TRAINING."
  }
}

variable "custom_model_hyperparameters" {
  description = "Parameters related to tuning the custom model."
  type        = map(string)
  default     = {
    "epochCount"              = "2"
    "batchSize"               = "1"
    "learningRate"            = "0.00001"
    "learningRateWarmupSteps" = "10"
  }
}

variable "custom_model_tags" {
  description = "A map of tag keys and values for the custom model."
  type        = map(string)
  default     = null
}

variable "custom_model_output_uri" {
  description = "The S3 URI where the output data is stored for custom model."
  type        = string
  default     = null
}

variable "custom_model_training_uri" {
  description = "The S3 URI where the training data is stored for custom model."
  type        = string
  default     = null
}
