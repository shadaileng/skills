---
name: typescript-conventions
description: TypeScript common pitfalls and conventions for all tarot-* projects.
Use when writing or reviewing TypeScript code. Covers HeadersInit handling and
common TS strict-mode errors.
---

## 不要直接展开 HeadersInit 联合类型

`HeadersInit` 是 `Headers | string[][] | Record<string, string>` 联合类型，
直接展开会导致 TS7053。**始终使用 `new Headers()` API 安全合并。**

```typescript
// ❌ 错误：vue-tsc strict 模式下展开联合类型报 TS7053
const headers = { ...getAuthHeaders(), ...(options?.headers || {}) }

// ✅ 正确
const h = new Headers(getAuthHeaders())
if (options?.headers) {
  new Headers(options.headers).forEach((v, k) => h.set(k, v))
}
```

## 修改完成后必须运行构建检查

所有 tarot-* 项目在代码修改完成后，**必须运行该项目的构建命令**以确保无类型错误：

| 项目 | 构建命令 |
|------|---------|
| tarot-admin | `pnpm build` |
| tarot-backend | `pnpm build` |
| tarot-miniprogram | `pnpm build:h5` |
| tarot-poster-service | `pnpm build` |
| tarot-reading-api | 无本地构建（deploy 时由 Wrangler 检查） |
