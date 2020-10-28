local databaseUrl = |||
	postgres://%(user)s:%(pass)s@%(host)s:%(port)d/%(database)s?pool=5
|||	% _.values.database;

{
	secret: {
		apiVersion: 'v1',
		kind: 'Secret',
		metadata: {
			name: '%-settings' % _.package.fullName,
		},
		type: 'Opaque',
		data: {
			database_url: std.base64(databaseUrl),
			secret_key_base: std.base64(_.values.secret_key_base),
		},
	},
	deployment: {
		apiVersion: "apps/v1",
		kind: "Deployment",
		metadata: {
			name: _.package.fullName,
			labels: {
				"app.kubernetes.io/name": _.package.fullName,
			},
		},
		spec: {
			replicas: 1,
			selector: {
				matchLabels: $.deployment.metadata.labels,
			},
			template: {
				metadata: {
					labels: $.deployment.metadata.labels,
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
								||| % _.values.database,
							],
						},
					],
					containers: [
						{
							name: "api",
							image: "registry.oddin.org/%s:%s" % [_.package.name, _.values.tag],
							imagePullPolicy: "IfNotPresent",
							env: [
								{
									name: "DATABASE_URL",
									valueFrom: {
										secretKeyRef: {
											name: $.secret.metadata.name,
											key: "database_url",
										},
									},
								},
								{
									name: "SECRET_KEY_BASE",
									valueFrom: {
										secretKeyRef: {
											name: $.secret.metadata.name,
											key: "secret_key_base",
										},
									},
								},
							],
						},
					],
				},
			},
		},
	},
	service: {
		kind: "Service",
		apiVersion: "v1",
		metadata: {
			name: _.package.fullName,
			labels: {
				"app.kubernetes.io/name": _.package.fullName,
			},
		},
		spec: {
			selector: $.deployment.metadata.labels,
			type: "ClusterIP",
			ports: [
				{
					name: "http",
					protocol: "TCP",
					port: 80,
					targetPort: 3000,
				},
			],
		},
	},
	ingress: {
		apiVersion: "projectcontour.io/v1",
		kind: "HTTPProxy",
		metadata: {
			name: _.package.fullName,
		},
		spec: {
			virtualhost: {
				fqdn: _.values.domain,
				tls: { secretName: _.values.tls_secret },
			},
			routes: [
				{
					conditions: [
						{ prefix: "/" },
					],
					services: [
						{
							name: $.service.metadata.name,
							port: 80,
						},
					],
				},
			],
		},
	},
}
