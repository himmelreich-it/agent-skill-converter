### Tool Name Mapping: Claude Code vs. Junie

When converting skills or plugins from Claude Code to Junie, use the following mapping to identify the equivalent Junie tools.

#### Core Tool Comparison Table

| Claude Code Tool | Junie Equivalent | Notes |
| :--- | :--- | :--- |
| `Bash` | `bash` | Same functionality; Junie has specific rules about avoiding interactive commands. |
| `Read` | `open` / `open_entire_file` | Junie's `open` is paginated (100 lines). Use `open_entire_file` for small files. |
| `Write` | `create` | Creates a new file or overwrites an existing one. |
| `Edit` | `search_replace` | Junie uses exact search-and-replace blocks rather than diff-style edits. |
| `MultiEdit` | `multi_edit` | Performs multiple search-and-replace operations in one call. |
| `Glob` | `search_paths_by_glob` | Searches for file paths matching a pattern. |
| `Grep` | `search_contents_by_grep` | Searches file contents using regex. |
| `LS` | `search_paths_by_glob` | For listing files, `search_paths_by_glob` or `bash -c "ls"` is used. |
| `WebSearch` | `web_search` | Similar functionality for external information gathering. |
| `WebFetch` | `bash` (via `curl`) | Junie does not have a dedicated fetch tool; use `bash` for HTTP requests. |
| `Task/Todo` | `update_status` | Junie uses `update_status` to maintain a persistent plan and status. |
| `Agent` | `agent_skill_read_doc` | Junie uses "Skills" (via `agent_skill_read_doc`) for specialized capabilities. |
| `AskUserQuestion` | Implicit / `answer` | Junie communicates via thoughts or the `answer` tool to end sessions. |

#### Key Procedural Differences

- **Pagination**: Claude Code's `Read` often returns the whole file or large chunks. Junie's `open` defaults to **100 lines** and provides `scroll_up`/`scroll_down` tools to navigate.
- **Search-and-Replace**: Junie's `search_replace` requires an **exact** line-for-line match of the search block. It does not support fuzzy matching or partial lines.
- **Plan Management**: Claude Code uses `TodoRead`/`TodoWrite` for task tracking. Junie uses a structured `plan` parameter within the `update_status` tool to track progress with specific markers (`*` for in-progress, `✓` for completed).
- **Session Termination**: Claude Code uses `exit_plan_mode` or similar to conclude. Junie uses `submit` (for solutions) or `answer` (for questions/info) to terminate the session.

#### Skill Integration
In your project, **Skills** are Markdown templates (found in the `/skills` directory) that guide the agent. While Claude Code uses these to prompt itself, Junie can also access specialized instructions via the `agent_skill_read_doc` tool if they are registered as "Agent Skills" in the system.
