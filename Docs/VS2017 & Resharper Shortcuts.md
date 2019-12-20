## General

| Command      | Results             |
| ------------ | ------------------- |
| `SHIFT+F10`  | Mouse Right Click.|  
| `` | .|
| `` | .|
| `` | .|

---

## VS2017

| Command      | Results             |
| ------------ | ------------------- |
| `CTRL+T` | Search for symbols.|
| `CTRL+G` | Go to Line.|
| `CTRL+1,F` | Go to File.|
| `CTRL+1,T` | Go to Type.|
| `CTRL+SHIFT+ENTER` | Switch Full Screen.|
| `CTRL+M+O ; CTRL+M+P` |  Collapse/Expand all methods.|
| `CTRL+M+M` | Collapse/expand/collapse selection.|
| `CTRL+BREAK` | Stop the current Build.|
| `Ctrl+[, Ctrl+S` | Sync With Active Document.|
| `CTRL+C` | On any file in Solution Explorer copies the path to the clipboard.|
| `CTRL+K, CTRL+S` | Surround selected code with construct i.e. try block etc.|
| `CTRL+K,CTRL+D` | Format the document.|
| `CTRL+[,P` | Shows only the changed files in solution explorer.|
| `CTRL+[,O` | Shows only the open files in solution explorer.|
| `CTRL+SHIFT+B` | Build the solution.|
| `CTRL+SHIFT+Y,CTRL+SHIFT+R` | Rebuild the solution.|
| `CTRL+SHIFT+Y,CTRL+SHIFT+C` | Clean the solution.|
| `CTRL+Y,CTRL+S` | Build.BuildSelection to build all the projs selected in solution explorer.|
| `CTRL+[,CTRL+S` | Sorround block with.|
| `ALT+F12` | Peek on highlighted code.|
| `` | .|
| `` | .|
| `` | .|
| `` | .|

---

## Resharper Tools

- **Navigate** : place cursor on a symbol, right click (SHIFT_F10) and use the Navigate function...
- **Hierarchy & Type Dependency Diagram** : place cursor on a symbol, right click (SHIFT_F10) >> Hierarchy

## Resharper Windows

- Assembly Explorer (from dotPeek)

## Resharper Shortcuts

| Command      | Results             |
| ------------ | ------------------- |
| `CTRL+Y,CTRL+T` | Search Everywhere.|
| `CTRL+SHIFT+ALT+K|DOWN|H|L` | Reposition selected code without breaking it.|
| `ALT+ENTER` | Perform Action i.e. Generate Code, Refactor, etc.|
| `CTRL+Y,CTRL+N` | Navigate To.|
| `Shift+Alt+L` | Locate in Solution/Assembly Explorer.|
| `CTRL+ALT+T` | Show Unit Test Session Window.|
| `CTRL+SHIFT+R` | Refactor this.|
| `ALT+ENTER` | On empty line shows Enter Action Name from which you can Navigate, Inspect, etc. just type the name of the action to perform...|
| `CTRL+ALT+RIGHT_ARROW` | Extend Selection.|
| `CTRL+SHIF+W` | Shrink Slelection.|
| `CTRL+SHIF+ENTER` | Statement Autocompletion.|
| `CTRL+E,U` | Surround block with template.|
| `CTRL+SHIFT+ALT+A` | Inspect This - Incoming+Outgoing+lots of other stuff!.|
| `CTRL+E,CTRL+H` | Inspect This >> Hierarchy [>> Show on Diagram]|  
| `` | .|
| `` | .|
| `` | .|

## Resharper Unit Tests and Coverage Shortcuts

| Command      | Results             |
| ------------ | ------------------- |
| `ALT+ENTER+(type in coverage)` | Executed when the cursor lies on any pieve of code it shows all the **test coverage** commands in a list from which a further action can be picked.|
| `ALT+ENTER+(type in covering)` | The same as above but now the list of tests that exercise that line of code is shown in a drop-down list. By clicking of these item the user navogates to the test.|
| `` | .|
| `` | .|
| `` | .|
| `` | .|

---

### Resharper Continuos TUnit Testing with dotCover

[dotCover 2018.1: Better continuous testing and more!](https://blog.jetbrains.com/dotnet/2018/03/21/dotcover-2018-1-better-continuous-testing/)

---

## Git FAQs

- [How do I exit the results of 'git diff' in Git Bash on windows?](https://stackoverflow.com/questions/9929457/how-do-i-exit-the-results-of-git-diff-in-git-bash-on-windows)

---

### Git Add and Remove

`git add file.txt` add the file to the index that is it **STAGES** the changes.

`git rm myfile.txt` is **NOT** the opposite of `git add`. Without ony option this commands deletes the fale from both the index and the warking area. If this file has never been pushed to the repository it is lost forever.

`git rm myfile.txt --cached` is the **UNTSAGE** command so the real opposite of `git add`. The option `--cached` lets the file/changes to be removed from the index but not the working area which is the unstage operation.

---

### Git Moving or Renaming 

The mechanics of renaming a file in the WA that is already in the index thus staged is the following.

1. rename a file in the working area
2. `git status` shows tha the former file has been deleted and a new file is in the working area but not in the index thus it says it is untracked.
3. `git add remamedfile.txt` add the renamed file to the index.
4. `git status` shows that there is still a **deleted** file **not staged**.
5. `git add oldfile.txt` stages the **delete** of the file that has been renamed.
6. `git status` shows that the are no longer untracked changes and the index is ahead of the repo.
7. `git commit -m "renamed file"` push the rename changes to the repo.

This whole process is also encapsulated by the convenience method `git mv`.
The advantage of `git mv` in renaming files is that you do not need to actually rename the file first and do the `git add`, instead git does all of it for you in one shot.

1. `git mv oldfile.txt newfile.txt`
2. `git mv oldfile.txt newfile.md`

---

### Git Reset

In order to understand Git Reset there are three main areas of Git that you must be familiar with.

1. [What is a branch and how it works](https://git-scm.com/book/en/v1/Git-Branching-What-a-Branch-Is)
2. What is the Index and how it works
3. What is the Repository and how it works

The following statements are all correct

- A commit is a NODE in a tree of commits.
- Remember that a branch is a specific COMMIT and the tree of commits of which this bcommit is root of. 
- The HEAD the pointer to some BRANCH stored in the Repository.
- The HEAD is a reference to the ROOT commit in the currently check-out branch. 
- You can think of the HEAD as the current branch but in reality the HEAD is a lightweight pointer to the current branch. 
- The commit to which the HEAD points to is the current commit.
- When you switch branches with **git checkout** the HEAD points to the root commit of the new branch.
- You can see what HEAD points to by doing: `cat .git/HEAD`.

---

**Git Reset does different things in different contexts** 

- With reset you can move the current branch to a specific commit node in the Repository thus that commit becomes the     root of the branch and due to the fact that the HEAD points to it it also si current commit. 
- HEAD keeps pointing to the current commit.

**Git Reset can be used with three options**

The final result of a git reset depends on which of the options is used with the command.
The state of the **Index** and the **Working Area** will differ according to which of the option is used.

1. `reset --hard`  
The reset command takes all the data from the Repository from the current commit and copies it to both
the Index and the Working Area.

2. `reset --mixed`   
The reset command takes all the data from the Repository from the current commit and copies it to the
Index but not to the Working Area. **This is the default option**.

3. `reset --soft`  
No data is copied to either the Index or the Working Area.


---
### [Example reset the branch to have the HEAD to point to a previous commint](https://app.pluralsight.com/player?course=mastering-git&author=paolo-perrotta&name=mastering-git-m3&clip=1&mode=live)  

Imagine that you might want to restore the state of the branch you are working on to that of some specific commit in it.
This means that you want the **branch** commit to becaome that commit and the **HEAD** pointer to point to it. All the
commits that follow the reset commit will be **garbage collected by GIT** as after this reset nothing will ever point to
them. The option `--hard` also **clears both the index and the working area** to the state the were at the commit `fbe5356`. 

`git reset --hard fbe5356`

### [Example reset the sate of the Index (Unstage)](https://app.pluralsight.com/player?course=mastering-git&author=paolo-perrotta&name=mastering-git-m3&clip=2&mode=live)  

Imagine that you have just added a file to the working area i.e `file.txt` then edited it and staged the file creation and the edits to it by typing `git add`. At this point the changes in the working are are **staged to the Index**. These changes are now next in line to be committed to the repository. However, you now realise that you want to make some changes to the working area and commit those changes ahead of those that are already staged. **How do we roll back the changes from the index to the working area? That is how do we unstage them?**.

One way to **unstage** files is to use the following

`git rm --cached`

This **resets the state of the Index area to that of the repository**. 

The other way is to use a **HEAD reset**. You can understand this better by breaking it down into two steps.

`git reset HEAD`
`git reset HEAD --mixed`

The effect of this command is the same as `git reset HEAD --mixed` as the `--mixed` option is **the default option** of the reset command. With this command you ask git to move the HEAD to point to the current branch which git is already doing but the `--mixed` option also implies that **the index is reset to teh state of the repo**. This has the same net effect as the **unstaging** caused by the `git rm --cached` discussed above.

`git reset HEAD file.txt`

Does the same as above but only in regard to teh single file `file.txt`.

### [Example reset the sate of the Index and the working area (Unstage+Discard)](https://app.pluralsight.com/player?course=mastering-git&author=paolo-perrotta&name=mastering-git-m3&clip=2&mode=live)  

`git reset HEAD --hard`

In this case both **the index and the working area** are reset to the set of the repository and all the staged content is unstaged and the changes in the working area discarded.

---

### Git Reset Typical Use Cases

---

### Other Commands that **move branches** as a side effect.

1. **git commit**

    When you commit the staged changes in the index are transferred to the Repository. 
    The HEAD 

2. **git merge** 

    Merge creates a new commit **in most cases** and when it does it moves the current 
    branch to point ot the new commit.

3. **rebase**

    Rebase is similar to **merge**. It creates new commits by copying existing commits 
    and moves the current branch to point to one of the new commits.

4. **pull**

    It gest new commits from the remote and updates the local and remote branches.

---

## Summary of Git Commands

| Command      | Results             |
| ------------ | ------------------- |
| `git status` | List the difference between the Working Area & The Index i.e. a file is added to the WA but it is not committed then it is shown by this command as a diff between the WA and the Index.|
| `git diff` | The same affect as `git status`.|
| `git add` | Updates the index using the ALL the current content found in the working tree, to prepare the content staged for the next commit..|
| `git add file.txt` | Stages the single file file.txt to the Index. The file is due to be committed.|
| `git diff --cached` | Shows the differences between the Index and the Repository. Changes that have been added ends up in the index but ar not yes in the Repo thus this command shows the changes that are to to end up in the Repo.|
| `git commit -m "some changes"` | Moves the changes staged in the index to the Repository and updates it accordingly.|
| `git push` | To push all the commits in teh Index to teh Repo.|
| `git checkout mybranch` | Does mainly two things 1) It moves the HEAD reference in the Repository to the selected branch. Remember that a branch is the CURRENT COMMIT. 2) It takes Dat from the new CURRENT COMMIT and it copies it from the Repo to the WA and the Index|
| `git branch` | Gets the list of branches available in the Repo.|
| `git branch diff master mybranch` | Shows the differences between the branch named master and the branch named mybranch.|
| `git rm myfile.txt` | rm stands for remove and with no other options given this command removes the myfile.txt from BOTH the warking are AND the index. However, GIT has a built-in safety feature in this case as it warns that by using this command the file myfile.txt will be lost forever as it is deleted from both the index and the working area AND it is NOT in the Repository!|
| `git rm myfile.txt -f` | The -f option forces the removal of myfile.txt from WA and Index.|
| `git rm myfile.txt --cached` | The --cached option allows the myfile.txt to be removed only from the index biut not from the working area. This is the **UNSTAGE** of the file.|
| `git rm file.txt` | Remove file.txt from the staging area. It kicks the file off the stage entirely it effectly deletes them. |
| `git rm --cached file.txt` | Removes the file.txt from the stage. That is, when you commit the file will be removed.|
| `git reset HEAD -- file.txt` | Reset file.txt in the staging area (Index) to the state where it was on the HEAD commit i.e. it undoes any changes you did to it since last commiting. If that change happens to be newly adding the file, then they will be equivalent. This is achieved by copying the file from the repo to the Index.|
| `git reset HEAD` | The same as above but it applies to all files in the staging area tha tis the Index.This is achieved by copying the all repo to the Index.|
| `git reset --hard fbe5356` | Resets the branch and HEAD to the given commit and restores the sate of working area and Index to the state they had at that commit.|
| `git checkout HEAD file.txt` | This is a special case and it sa the effect of checking out from the repo the file.txt back into the Index and the Working Area. This is convenient when you want to just reset a single file in both areas and not the whole Index.|
| `git stash --include-untracked` | The `--include-untracked` will also push to the stash all the staged changes and all files that are in the working area but are not traked. The stash command is automatically followed by a **checkout** command on the current branch which reset the state of the index and working area to that of the branch.|
| `git merge tomato` | Invokes a merge operation of the **tomato branch into the current branch**.|
| `git log` | Shows the history of the checked out branch. However, this is not very useful by itself as it just outputs a list.|
| `git log --graph` | This is much more useful as it outputs a history graph.|
| `git log --graph --decorate --oneline` | The `--decorate` option shows the position of references such as branches. The `--oneline` formats the log so that each commit tales a single line.|
| `git show abcd1234` | Shows all the details relative to the give commit hash `abcd1234` i.e. lines added and lines removed or modified per each file or files added and removed, etc.|
| `git show somebranch` | As above but the name of teh branch is used instead of that of the corresponding commit.|
| `git show HEAD` | The sama as above but the reference HEAD is used. This time the details about the branch commit pointed to by HEAD are shown.|
| `git show HEAD^` | The caret `^` means the parent commit. In this case the details about the parent commit of the commit pointed to by HEAD is displayed|
| `` | .|
| `git stash save "my_changes"` | Stashes the staged changes that is those that are in the Index and names the stash "my_changes".|
| `git stash list` | Lists the items in the stash.|
| `git stash apply` | Applies the last stashed changes to the Working Area.|
| `git stash apply stash@{11}` | Applies the changes in the stash 11.|
| `git stash clear` | Clear the whole stash.|
| `git stash drop` | Drops the top stash.|
| `git stash drop stash@{5}` | Drops the top stash 5.|
| `` | .|

---

## Git Bash

| Command      | Results             |
| ------------ | ------------------- |
| `Q` | To break ouf from the `git diff...`.|
| `clear` | To clear the output.|
| `history -c` | To clear the whole command history.|
| `reset` | This is what you normally want! It clears the screen for good but preserve the command history.|
| `` | .|

---