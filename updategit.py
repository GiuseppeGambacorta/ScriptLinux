import os
from git import Repo, GitCommandError
from datetime import datetime

# Require GitPython installed
REPO_PATH = "/home/ubuntu/ChapterOne"  
BRANCH = "main"  # o "master"
LOG_FILE = "/home/ubuntu/git_update.log"

def log(message):
    timestamp = datetime.now().strftime("[%Y-%m-%d %H:%M:%S]")
    with open(LOG_FILE, "a") as f:
        f.write(f"{timestamp} {message}\n")
    print(f"{timestamp} {message}")

def main():
    if not os.path.exists(REPO_PATH):
        log(f"Errore: directory '{REPO_PATH}' non trovata.")
        return

    try:
        repo = Repo(REPO_PATH)
        origin = repo.remotes.origin

        # Fetch aggiornamenti da remoto
        origin.fetch()
        log("Fetch eseguito.")

        local_sha = repo.commit(BRANCH).hexsha
        remote_sha = repo.commit(f"origin/{BRANCH}").hexsha

        if local_sha != remote_sha:
            log("Nuovi commit trovati. Eseguo pull...")
            origin.pull(BRANCH)
            log("Pull completato con successo.")
        else:
            log("Nessun aggiornamento trovato.")

    except GitCommandError as e:
        log(f"Errore Git: {e}")
    except Exception as e:
        log(f"Errore generico: {e}")

if __name__ == "__main__":
    main()
