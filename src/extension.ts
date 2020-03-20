// The module 'vscode' contains the VS Code extensibility API
// Import the module and reference it with the alias vscode in your code below
import * as vscode from 'vscode';

// this method is called when your extension is activated
// your extension is activated the very first time the command is executed
export function activate(context: vscode.ExtensionContext) {

  // Use the console to output diagnostic information (console.log) and errors (console.error)
  // This line of code will only be executed once when your extension is activated
  console.log('Congratulations, your extension "gemviewer" is now active!');

  // The command has been defined in the package.json file
  // Now provide the implementation of the command with registerCommand
  // The commandId parameter must match the command field in package.json

  // context.subscriptions.push(disposable);

  let terminal: vscode.Terminal;
  const TERMINAL_NAME: string = 'Ruby Gem Viewer';

  let runLine = vscode.commands.registerCommand('extension.gemViewer', () => {
      vscode.window.setStatusBarMessage('Gem Viewer: Opening file', 3000);

      if (vscode.window.activeTextEditor !== undefined) {
          const editor: vscode.TextEditor = vscode.window.activeTextEditor;
          const document: vscode.TextDocument = editor.document;

          const start = editor.selection.start;
          const end = editor.selection.end;
          let word = document.getText(new vscode.Range(start, end));

          issueCommand(`${word}`);
      }
  });

  context.subscriptions.push(runLine);

  function issueCommand(launcher_args: string): void {
      const terminal = findOrCreateTerminal();

      terminal.show();
      terminal.sendText(`ruby ~/src/vs-code-gem-viewer/main.rb ${launcher_args}`);
  }

  function findOrCreateTerminal(): vscode.Terminal {
      if (terminal === undefined) {
          terminal = vscode.window.createTerminal(TERMINAL_NAME);
      }

      return terminal;
  }
}

// this method is called when your extension is deactivated
export function deactivate() {}
