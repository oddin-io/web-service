local values = import "./values.json";

{
  apiVersion: "v1",
  kind: "List",
  items: [
    {
      apiVersion: "apps/v1",
      kind: "Deployment",
      metadata: {
        name: "api",
        labels: {
          "app.kubernetes.io/name": "api"
        }
      },
      spec: {
        replicas: 1,
        selector: {
          matchLabels: {
            "app.kubernetes.io/name": "api"
          }
        },
        template: {
          metadata: {
            labels: {
              "app.kubernetes.io/name": "api"
            }
          },
          spec: {
            initContainers: [
              {
                name: "wait-for-postgresql",
                image: "busybox:1.31",
                imagePullPolicy: "IfNotPresent",
                command: [
                  "sh",
                  "-c",
                  |||
                    printf "Waiting for postgres "
                    until printf "." && nc -z -w 2 %(host)s %(port)d; do
                      sleep 2;
                    done;
                    echo ' ✓'
                  ||| % values.database
                ]
              }
            ],
            containers: [
              {
                name: "api",
                image: "registry.oddin.org/api",
                imagePullPolicy: "Always",
                env: [
                  {
                    name: "DATABASE_URL",
                    valueFrom: {
                      secretKeyRef: {
                        name: "api-settings",
                        key: "database_url"
                      }
                    }
                  },
                  {
                    name: "SECRET_KEY_BASE",
                    valueFrom: {
                      secretKeyRef: {
                        name: "api-settings",
                        key: "secret_key_base"
                      }
                    }
                  }
                ]
              }
            ]
          }
        }
      }
    },
    {
      kind: "Service",
      apiVersion: "v1",
      metadata: {
        name: "api",
        labels: {
          "app.kubernetes.io/name": "api"
        }
      },
      spec: {
        selector: {
          "app.kubernetes.io/name": "api"
        },
        type: "ClusterIP",
        ports: [
          {
            name: "http",
            protocol: "TCP",
            port: 80,
            targetPort: 3000
          }
        ]
      }
    },
    {
      apiVersion: "projectcontour.io/v1",
      kind: "HTTPProxy",
      metadata: {
        name: "api"
      },
      spec: {
        virtualhost: {
          fqdn: "api.oddin.localhost",
          tls: {
            secretName: "domain-tls"
          }
        },
        routes: [
          {
            conditions: [
              {
                prefix: "/"
              }
            ],
            services: [
              {
                name: "api",
                port: 80
              }
            ]
          }
        ]
      }
    }
  ]
}
