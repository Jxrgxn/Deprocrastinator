//
//  ViewController.m
//  DeprocrastinatorV2
//
//  Created by Basel Farag on 9/27/14.
//  Copyright (c) 2014 NextTierGames. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@property UITextField *text;
@property NSArray *textArray;
@property (weak, nonatomic) IBOutlet UITextField *myTextField;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) NSMutableArray *thingsToDo;
@property BOOL isEditing;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.myTextField.delegate = self;
    self.myTableView.delegate = self;
    self.thingsToDo = [NSMutableArray new];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    UIControlEventTouchUpInside will allow the user to cancel their selection by dragging their finger across the screen
    [button addTarget:self action:@selector(onEditButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Edit" forState:UIControlStateNormal];
    button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    [self.view addSubview:button];

    self.isEditing = NO;

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onAddButtonPressed:(id)sender {
    [self.thingsToDo addObject:self.myTextField.text];
    self.myTextField.text = @"";
    [self.myTextField resignFirstResponder];
    [self.myTableView reloadData];
}

#pragma UITableViewDataSource

//  Attaches the number of rows in TableView to the number of things stored in
//  the thingsToDo array.
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.thingsToDo.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellRow";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellRow"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [self.thingsToDo objectAtIndex:indexPath.row];
    cell.textLabel.highlightedTextColor = [UIColor greenColor];
    cell.detailTextLabel.text = @"testing";
    return cell;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [self.myTableView setEditing:editing animated:YES];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isEditing == YES)
    {
        [self.thingsToDo removeObjectAtIndex:indexPath.row]; //Update the actual data source
        [self.myTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(void)onEditButtonPressed:(id)sender
{
    if (!self.isEditing)
    {
        self.isEditing = YES;
        [sender setTitle:@"Done" forState:UIControlStateNormal];
        [self setEditing:YES animated:YES];
    }
    else if (self.isEditing)
    {
        self.isEditing = NO;
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
    }

}


@end
