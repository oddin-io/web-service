local values = import "./values.json";

{
  apiVersion: 'v1',
  kind: 'Secret',
  metadata: {
    name: 'api-settings',
  },
  type: 'Opaque',
  data: {
    database_url: std.base64(values.database.url),
    secret_key_base: std.base64(values.secret_key_base),
  },
}
