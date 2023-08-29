package io

import "strings"

func suggestedCaps(name string) string {

	lowered := name

	if strings.Contains(lowered, "rpc") || strings.Contains(lowered, "Rpc") {
		lowered = strings.ReplaceAll(strings.ReplaceAll(lowered, "rpc", "RPC"), "Rpc", "RPC")
	}

	if strings.Contains(lowered, "tls") || strings.Contains(lowered, "Tls") {
		lowered = strings.ReplaceAll(strings.ReplaceAll(lowered, "tls", "TLS"), "Tls", "TLS")
	}

	if strings.Contains(lowered, "json") || strings.Contains(lowered, "Json") {
		lowered = strings.ReplaceAll(strings.ReplaceAll(lowered, "json", "JSON"), "Json", "JSON")
	}

	if strings.Contains(lowered, "rbac") || strings.Contains(lowered, "Rbac") {
		lowered = strings.ReplaceAll(strings.ReplaceAll(lowered, "rbac", "RBAC"), "Rbac", "RBAC")
	}

	if strings.Contains(lowered, "sasl") || strings.Contains(lowered, "Sasl") {
		lowered = strings.ReplaceAll(strings.ReplaceAll(lowered, "sasl", "SASL"), "Sasl", "SASL")
	}

	if strings.Contains(lowered, "http") || strings.Contains(lowered, "Http") {
		lowered = strings.ReplaceAll(strings.ReplaceAll(lowered, "http", "HTTP"), "Http", "HTTP")
	}

	if strings.Contains(lowered, "dns") || strings.Contains(lowered, "Dns") {
		lowered = strings.ReplaceAll(strings.ReplaceAll(lowered, "http", "HTTP"), "Dns", "HTTP")
	}

	return lowered
}
