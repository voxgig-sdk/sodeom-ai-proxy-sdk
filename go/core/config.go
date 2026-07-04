package core

func MakeConfig() map[string]any {
	return map[string]any{
		"main": map[string]any{
			"name": "SodeomAiProxy",
		},
		"feature": map[string]any{
			"test": map[string]any{
				"options": map[string]any{
					"active": false,
				},
			},
		},
		"options": map[string]any{
			"base": "https://sodeom.com",
			"headers": map[string]any{
				"content-type": "application/json",
			},
			"entity": map[string]any{
				"ain": map[string]any{},
				"ain2": map[string]any{},
			},
		},
		"entity": map[string]any{
			"ain": map[string]any{
				"fields": []any{
					map[string]any{
						"active": true,
						"name": "answer",
						"req": true,
						"type": "`$STRING`",
						"index$": 0,
					},
				},
				"name": "ain",
				"op": map[string]any{
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"active": true,
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"active": true,
											"example": "Say hi",
											"kind": "query",
											"name": "query",
											"orig": "query",
											"reqd": true,
											"type": "`$STRING`",
										},
									},
								},
								"method": "GET",
								"orig": "/ai",
								"parts": []any{
									"ai",
								},
								"select": map[string]any{
									"exist": []any{
										"query",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"index$": 0,
							},
						},
						"key$": "load",
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"ain2": map[string]any{
				"fields": []any{
					map[string]any{
						"active": true,
						"name": "answer",
						"req": true,
						"type": "`$STRING`",
						"index$": 0,
					},
					map[string]any{
						"active": true,
						"name": "max_token",
						"req": false,
						"type": "`$INTEGER`",
						"index$": 1,
					},
					map[string]any{
						"active": true,
						"name": "message",
						"req": true,
						"type": "`$ARRAY`",
						"index$": 2,
					},
					map[string]any{
						"active": true,
						"name": "model",
						"req": false,
						"type": "`$STRING`",
						"index$": 3,
					},
					map[string]any{
						"active": true,
						"name": "temperature",
						"req": false,
						"type": "`$NUMBER`",
						"index$": 4,
					},
				},
				"name": "ain2",
				"op": map[string]any{
					"create": map[string]any{
						"input": "data",
						"name": "create",
						"points": []any{
							map[string]any{
								"active": true,
								"args": map[string]any{},
								"method": "POST",
								"orig": "/ai",
								"parts": []any{
									"ai",
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"index$": 0,
							},
						},
						"key$": "create",
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
		},
	}
}

func makeFeature(name string) Feature {
	switch name {
	case "test":
		if NewTestFeatureFunc != nil {
			return NewTestFeatureFunc()
		}
	default:
		if NewBaseFeatureFunc != nil {
			return NewBaseFeatureFunc()
		}
	}
	return nil
}
